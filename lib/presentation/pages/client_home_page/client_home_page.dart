import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:evemanager/presentation/widgets/home/main_drawer.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:evemanager/dependency_injection.dart' as di;

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({
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
      drawer: MainDrawer(
        uid: uid,
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Container(
              color: lightBlue.withOpacity(0.1),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: TabBar(
                        indicatorPadding: EdgeInsets.zero,
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Wedding Halls'),
                          Tab(text: 'Food Cattering'),
                          Tab(text: 'Decoration'),
                          Tab(text: 'Tab 3'),
                          Tab(text: 'Tab 3'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Tab1Body(),
                  Tab1Body(),
                  Tab3Body(),
                  Tab3Body(),
                  Tab3Body(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab1Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<MarriageHallCubit>(context)
            .GetMarriageHallForClient();
      },
      child: FutureBuilder(
          future: BlocProvider.of<MarriageHallCubit>(context)
              .GetMarriageHallForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<MarriageHallCubit, MarriageHallState>(
                listener: (context, state) {
                  if (state is MarriageHallFailure) {
                    DisplayToast('Failed To Get Marriage Halls');
                  }
                },
                builder: (context, state) {
                  if (state is MarriageHallSuccessForClient) {
                    //  if (state is MarriageHallSuccess) {
                    
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
                                child: BuildHallCardForClient(
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
    );
  }
}

// class Tab2Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         await BlocProvider.of<MarriageHallCubit>(context)
//             .GetMarriageHallForClient();
//       },
//       child: FutureBuilder(
//           future: BlocProvider.of<MarriageHallCubit>(context)
//               .GetMarriageHallForClient(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return BlocConsumer<MarriageHallCubit, MarriageHallState>(
//                 listener: (context, state) {
//                   if (state is MarriageHallFailure) {
//                     DisplayToast('Failed To Get Marriage Halls');
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is MarriageHallSuccessForClient) {
//                     if (state.marriageHallEntities?.isEmpty ?? false) {
//                       return Center(
//                         child: Text('No wedding halls listed'),
//                       );
//                     } else {
//                       return Container(
//                         child: ListView.builder(
//                           itemCount: state.marriageHallEntities?.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                                 child: BuildHallCardForClient(
//                                     hallData:
//                                         state.marriageHallEntities![index]));
//                           },
//                         ),
//                       );
//                     }
//                   } else if (state is MarriageHallLoading) {
//                     return LoadingBody();
//                   } else {
//                     return Center(
//                       child: Container(
//                         child: Text('Failed To Show Wedding Halls'),
//                       ),
//                     );
//                   }
//                 },
//               );
//             } else {
//               return LoadingBody();
//             }
//           }),
//     );
//   }
// }

class Tab3Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Body of Tab 3'),
    );
  }
}

class BuildHallCardForClient extends StatelessWidget {
  BuildHallCardForClient({super.key, required this.hallData});
  final MarriageHallEntity hallData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              hallData.images![0],
              width: 200,
              height: 180,
              fit: BoxFit.cover,
            ),
          ), // Other details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hallData.name!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Capacity: ${hallData.capacity}'),
                Text('Contact: ${hallData.contact}'),
                (hallData.availability == null || hallData.pricingInfo == null)
                    ? Text(
                        'Not published ',
                        style: TextStyle(color: Colors.red),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
