import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/entertainment/entertainment_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_entertainment_card.dart';

class EntertainmentAdminHome extends StatelessWidget {
  EntertainmentAdminHome({Key? key, required this.uid});
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Navigator.pushNamed(context, PageNames.AddEntertainmentScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<EntertainmentCubit>(context).GetEntertainmentForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<EntertainmentCubit>(context).GetEntertainmentForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<EntertainmentCubit, EntertainmentState>(
                listener: (context, state) {
                  if (state is EntertainmentFailure) {
                    DisplayToast('Failed To Get Entertainment Services');
                  }
                },
                builder: (context, state) {
                  if (state is EntertainmentSuccessForOwner) {
                    if (state.entertainment_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Entertainment Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.entertainment_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminEntertainmentCard(
                                entertainmentEntity: state.entertainment_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is EntertainmentFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Entertainment Services'),
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
