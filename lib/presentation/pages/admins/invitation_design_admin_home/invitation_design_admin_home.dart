import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/invitation_design/invitation_design_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_invitation_design_card.dart';

class InvitationDesignAdminHome extends StatelessWidget {
  InvitationDesignAdminHome({Key? key, required this.uid});
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
          Navigator.pushNamed(context, PageNames.AddInvitationDesignScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<InvitationDesignCubit>(context).getInvitationDesignForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<InvitationDesignCubit>(context).getInvitationDesignForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<InvitationDesignCubit, InvitationDesignState>(
                listener: (context, state) {
                  if (state is InvitationDesignFailure) {
                    DisplayToast('Failed To Get Invitation Design Services');
                  }
                },
                builder: (context, state) {
                  if (state is InvitationDesignSuccessForOwner) {
                    if (state.invitation_design_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Invitation Design Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.invitation_design_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminInvitationDesignCard(
                                invitationDesignEntity: state.invitation_design_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is InvitationDesignFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Invitation Design Services'),
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
