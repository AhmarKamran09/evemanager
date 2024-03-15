import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/invitation_design/invitation_design_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_invitation_design_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitationDesignListScreen extends StatelessWidget {
  const InvitationDesignListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invitation Design Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<InvitationDesignCubit>(context).getInvitationDesignForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<InvitationDesignCubit>(context).getInvitationDesignForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<InvitationDesignCubit, InvitationDesignState>(
                listener: (context, state) {
                  if (state is InvitationDesignFailure) {
                    DisplayToast('Failed To Get Invitation Design Services');
                  }
                },
                builder: (context, state) {
                  if (state is InvitationDesignSuccessForClient) {
                    if (state.invitation_design_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No invitation design services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.invitation_design_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientInvitationDesignCard(
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
