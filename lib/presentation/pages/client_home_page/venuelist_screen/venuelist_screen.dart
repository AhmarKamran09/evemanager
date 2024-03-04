import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venues"),
        // backgroundColor: ,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<VenueCubit>(context).GetVenueForClient();
        },
        child: FutureBuilder(
            future: BlocProvider.of<VenueCubit>(context).GetVenueForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<VenueCubit, VenueState>(
                  listener: (context, state) {
                    if (state is VenueFailure) {
                      DisplayToast('Failed To Get Venues');
                    }
                  },
                  builder: (context, state) {
                    if (state is VenueSuccessForClient) {
                      if (state.VenueEntities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No Venues listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.VenueEntities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: ClientVenuesCard(
                                      venue: state.VenueEntities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is VenueFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Venues'),
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

class ClientVenuesCard extends StatelessWidget {
  ClientVenuesCard({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          backgroundColor: Colors.white,
          builder: (context) {
            return Container(
              height: 1200,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beautiful Bottom Sheet',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'This is a simple example of a beautiful bottom sheet.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
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
                venue.images![0],
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
                    venue.name!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Capacity: ${venue.capacity}'),
                  Text('Contact: ${venue.contact}'),
                  (venue.availability == null || venue.pricingInfo == null)
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
