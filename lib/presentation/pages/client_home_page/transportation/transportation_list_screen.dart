import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/transportation/transportation_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_transportation_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransportationListScreen extends StatelessWidget {
  const TransportationListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transportation Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<TransportationCubit>(context).getTransportationForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<TransportationCubit>(context).getTransportationForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<TransportationCubit, TransportationState>(
                listener: (context, state) {
                  if (state is TransportationFailure) {
                    DisplayToast('Failed To Get Transportation Services');
                  }
                },
                builder: (context, state) {
                  if (state is TransportationSuccessForClient) {
                    if (state.transportation_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No transportation services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.transportation_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientTransportationCard(
                                transportationEntity: state.transportation_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is TransportationFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Transportation service'),
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
