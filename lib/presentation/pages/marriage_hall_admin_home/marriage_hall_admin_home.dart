import 'package:evemanager/constants.dart';
// import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:evemanager/presentation/widgets/home/main_drawer.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:evemanager/presentation/widgets/marriage_hall_admin_home/build_hall_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarriageHallAdminHome extends StatelessWidget {
  MarriageHallAdminHome({
    super.key,
    required this.uid,
  });
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue.withOpacity(0.5),
        centerTitle: true,
        title: Text(
          'EVE MANAGER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageNames.AddMarriageHallScreen,
              arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(
        uid: uid,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<MarriageHallCubit>(context)
              .GetMarriageHallForOwner(uid!);
        },
        child: FutureBuilder(
            future: BlocProvider.of<MarriageHallCubit>(context)
                .GetMarriageHallForOwner(uid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<MarriageHallCubit, MarriageHallState>(
                  listener: (context, state) {
                    if (state is MarriageHallFailure) {
                      DisplayToast('Failed To Get Marriage Halls');
                    }
                  },
                  builder: (context, state) {
                    if (state is MarriageHallSuccessForOwner) {
                    // if (state is MarriageHallSuccess) {
                      if (state.marriageHallEntities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No wedding halls listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.marriageHallEntities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: BuildHallCard(
                                      hallData:
                                          state.marriageHallEntities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is MarriageHallFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Wedding Halls'),
                        ),
                      );
                    } else {
                      return LoadingBody();
                    }
                  },
                );
              } else {
                return LoadingBody();
              }
            }),
      ),
    );
  }
}

//  DefaultTabController(
//         length: 1,
//         child: Column(
//           children: [
//             Container(
//               color: lightBlue.withOpacity(0.1),
//               margin: EdgeInsets.zero,
//               padding: EdgeInsets.all(0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       height: kToolbarHeight,
//                       child: TabBar(
//                         indicatorPadding: EdgeInsets.zero,
//                         isScrollable: true,
//                         tabs: [
//                           Tab(text: 'Manage Halls'),
//                           // Tab(text: 'Add Marriage Halls'),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   ManageHalls(
//                     uid: uid!,
//                   ),
//                   // AddMarriageHalls(
//                   // uid: uid!,
//                   // )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
