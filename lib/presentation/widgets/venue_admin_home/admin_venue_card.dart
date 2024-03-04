import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminVenueCard extends StatelessWidget {
  AdminVenueCard({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: venue.images != null &&
                        venue.images!.isNotEmpty // Example of null check
                    ? Image.file(
                        venue.images![0],
                        width: 200,
                        height: 180,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(),
              ), // Other details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue.name ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Capacity: ${venue.capacity ?? ""}'),
                    Text('Contact: ${venue.contact ?? ""}'),
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
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageNames.UpdateVenueScreen,
                        arguments: venue);
                  },
                  icon: Icon(Icons.update)),
              IconButton(
                  onPressed: () {
                    _deletevenue(context, venue);
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }

  void _deletevenue(BuildContext context, VenueEntity venue) async {
    await BlocProvider.of<VenueCubit>(context)
        .DeleteVenue(hallid: venue.id!, owner_id: venue.owner_id!);
  }
}
