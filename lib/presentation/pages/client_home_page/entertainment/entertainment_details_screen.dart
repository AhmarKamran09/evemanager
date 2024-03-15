import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:flutter/material.dart';

class EntertainmentDetailsScreen extends StatelessWidget {
  const EntertainmentDetailsScreen({Key? key, required this.entertainmentEntity});
  final EntertainmentEntity entertainmentEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entertainment Details'),
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
              child: entertainmentEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: entertainmentEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            entertainmentEntity.images![index],
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
