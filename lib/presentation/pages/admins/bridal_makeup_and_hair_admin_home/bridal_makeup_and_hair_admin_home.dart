import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/bridal_makeup_and_hair/bridal_makeup_hair_cubit.dart';
import 'package:evemanager/presentation/widgets/_admin_home_page/admin_bridal_makeup_and_hair_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BridalMAkeupAndHairAdminHome extends StatelessWidget {
  BridalMAkeupAndHairAdminHome({
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PageNames.ProfileMenuPage,
                    arguments: uid);
              },
              icon: Icon(size: 40, Icons.person)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageNames.AddBridalMakeupAndHairScreen,
              arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<BridalMakeupHairCubit>(context)
              .GetBridalMakeupHairForOwner(uid!);
        },
        child: FutureBuilder(
            future:BlocProvider.of<BridalMakeupHairCubit>(context)
              .GetBridalMakeupHairForOwner(uid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<BridalMakeupHairCubit, BridalMakeupHairState>(
                  listener: (context, state) {
                    if (state is BridalMakeupHairFailure) {
                      DisplayToast('Failed To Get Catering Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is BridalMakeupHairSuccessForOwner) {
                      if (state.bridal_makeup_entity?.isEmpty ?? false) {
                        return Center(
                          child: Text('No bridal Services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.bridal_makeup_entity?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: AdminBridalMakeupAndHairCard(
                                      bridalMakeupAndHairEntity:
                                          state.bridal_makeup_entity![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is BridalMakeupHairFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show bridal Services'),
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
