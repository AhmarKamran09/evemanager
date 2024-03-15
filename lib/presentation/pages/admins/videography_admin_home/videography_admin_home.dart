import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/videography/videography_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_videography_card.dart';

class VideographyAdminHome extends StatelessWidget {
  VideographyAdminHome({Key? key, required this.uid});
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
              Navigator.pushNamed(context, PageNames.ProfileMenuPage, arguments: uid);
            },
            icon: Icon(Icons.person, size: 40),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageNames.AddVideographyScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<VideographyCubit>(context).getVideographyForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<VideographyCubit>(context).getVideographyForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<VideographyCubit, VideographyState>(
                listener: (context, state) {
                  if (state is VideographyFailure) {
                    DisplayToast('Failed To Get Videography Services');
                  }
                },
                builder: (context, state) {
                  if (state is VideographySuccessForOwner) {
                    if (state.videography_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Videography Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.videography_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminVideographyCard(
                                videographyEntity: state.videography_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is VideographyFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Videography Services'),
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
          },
        ),
      ),
    );
  }
}
