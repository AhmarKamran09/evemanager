import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:flutter/material.dart';

class PhotographyDetailsScreen extends StatelessWidget {
  const PhotographyDetailsScreen({Key? key, required this.photographyEntity});
  final PhotographyEntity photographyEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photography Details'),
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
              child: photographyEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: photographyEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            photographyEntity.images![index],
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
