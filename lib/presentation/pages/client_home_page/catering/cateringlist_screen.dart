
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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


class ClientCateringCard extends StatelessWidget {
  ClientCateringCard({super.key, required this.catering});
  final CateringEntity catering;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.CateringDetailsScreen,arguments: catering);
      },
      child: Card(
        elevation: 30.0,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                catering.images![0],
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
                    catering.name!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Capacity: ${catering.capacity}'),
                  Text('Contact: ${catering.contact}'),
                  (catering.availability == null || catering.pricingInfo == null)
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
      ),
    );
  }
}
