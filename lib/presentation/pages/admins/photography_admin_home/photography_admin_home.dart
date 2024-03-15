import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/photography/photography_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_photography_card.dart';

class PhotographyAdminHome extends StatelessWidget {
  PhotographyAdminHome({Key? key, required this.uid});
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
          Navigator.pushNamed(context, PageNames.AddPhotographyScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<PhotographyCubit>(context).getPhotographyForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<PhotographyCubit>(context).getPhotographyForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<PhotographyCubit, PhotographyState>(
                listener: (context, state) {
                  if (state is PhotographyFailure) {
                    DisplayToast('Failed To Get Photography Services');
                  }
                },
                builder: (context, state) {
                  if (state is PhotographySuccessForOwner) {
                    if (state.photography_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Photography Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.photography_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminPhotographyCard(
                                photographyEntity: state.photography_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is PhotographyFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Photography Services'),
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
