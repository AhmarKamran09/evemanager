import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:flutter/material.dart';

class DecorationDetailsScreen extends StatelessWidget {
  DecorationDetailsScreen({Key? key, required this.decorationEntity});
  final DecorationsEntity decorationEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decoration Details'),
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
              child: decorationEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: decorationEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            decorationEntity.images![index],
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
