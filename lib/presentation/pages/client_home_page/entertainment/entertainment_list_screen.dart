import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/entertainment/entertainment_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_entertainment_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntertainmentListScreen extends StatelessWidget {
  const EntertainmentListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entertainment Services"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<EntertainmentCubit>(context)
                .GetEntertainmentForClient();
          },
          child: FutureBuilder(
            future: BlocProvider.of<EntertainmentCubit>(context)
                .GetEntertainmentForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<EntertainmentCubit, EntertainmentState>(
                  listener: (context, state) {
                    if (state is EntertainmentFailure) {
                      DisplayToast('Failed To Get Entertainment Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is EntertainmentSuccessForClient) {
                      if (state.entertainment_entity?.isEmpty ?? false) {
                        return Center(
                          child: Text('No entertainment services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.entertainment_entity?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ClientEntertainmentCard(
                                  entertainmentEntity:
                                      state.entertainment_entity![index],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else if (state is EntertainmentFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Entertainment service'),
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
        ));
  }
}
