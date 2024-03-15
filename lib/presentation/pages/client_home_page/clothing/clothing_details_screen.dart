import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:flutter/material.dart';

class ClothingDetailsScreen extends StatelessWidget {
  ClothingDetailsScreen({Key? key, required this.clothingEntity});

  final ClothingEntity clothingEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing Details'),
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
              child: clothingEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: clothingEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            clothingEntity.images![index],
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
