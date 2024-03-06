

import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:flutter/material.dart';

class CateringDetailsScreen extends StatelessWidget {
   CateringDetailsScreen({super.key, required this.cateringEntity});
 final CateringEntity cateringEntity;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Catering Details'),
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
              child: cateringEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: cateringEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            cateringEntity.images![index],
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