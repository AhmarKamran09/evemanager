import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:flutter/material.dart';

class VenueDetailsScreen extends StatelessWidget {
  VenueDetailsScreen({super.key, required this.venueEntity});
  final VenueEntity venueEntity;
  @override
  Widget build(BuildContext context) {
    // List<File> selectedImages = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              // Show images in horizontal scroll in full screen mode
            },
            child: Container(
              margin: EdgeInsets.all(16),
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: venueEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: venueEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            venueEntity.images![index],
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No images'),
                    ),
            ),
          ),
          ],
      ),
    );
  }
}
