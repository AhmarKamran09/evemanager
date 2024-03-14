

import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:flutter/material.dart';

class BridalMakeupAndHairDetailsScreen extends StatelessWidget {
   BridalMakeupAndHairDetailsScreen({super.key, required this.bridalEntity});
 final BridalMakeupAndHairEntity bridalEntity;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('bridal ANd Makeup Details'),
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
              child: bridalEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: bridalEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            bridalEntity.images![index],
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