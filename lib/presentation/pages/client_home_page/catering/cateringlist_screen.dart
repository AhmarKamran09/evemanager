
import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/client_home_page/client_catering_card.dart';

class CateringListScreen extends StatelessWidget {
  const CateringListScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Catering"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<CateringserviceCubit>(context).GetCateringServicesForClient();
        },
        child: FutureBuilder(
            future: BlocProvider.of<CateringserviceCubit>(context).GetCateringServicesForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<CateringserviceCubit, CateringserviceState>(
                  listener: (context, state) {
                    if (state is VenueFailure) {
                      DisplayToast('Failed To Get Catering Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is CateringserviceSuccessForClient) {
                      if (state.catering_entities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No Catering services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.catering_entities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: ClientCateringCard(
                                      catering: state.catering_entities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is CateringserviceFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Catering'),
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
