import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/cubit/rating/rating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ClientVenuesCard extends StatelessWidget {
  ClientVenuesCard({super.key, required this.venue, required this.uid});
  final VenueEntity venue;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageNames.VenueDetailsScreen,
          arguments: {
            'venue': venue,
            'uid': uid,
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
            ),
            // Other details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        venue.name!,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<RatingCubit, RatingState>(
                        builder: (context, state) {
                          if (state is RatingSuccess) {
                            print(state.ratingvalue);
                            return Text(state.ratingvalue.toString());
                            // print(state.serviceId);
                            // return RatingBarIndicator(
                            //     itemCount: 5,
                            //     rating: state.ratingvalue,
                            //     itemSize: 30.0,
                            //     itemBuilder: (context, index) {
                            //       return Icon(
                            //         Icons.star_outlined,
                            //         color: Colors.amber,
                            //       );
                            //     });
                          } else {
                            print(state);
                            return RatingBarIndicator(
                                itemCount: 5,
                                rating: 0,
                                itemSize: 30.0,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star_outlined,
                                    color: Colors.amber,
                                  );
                                });
                          }
                        },
                      )
                    ],
                  ),
                  Text('Capacity: ${venue.capacity}'),
                  Text('Contact: ${venue.contact}'),
                  (venue.pricingInfo == null)
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
