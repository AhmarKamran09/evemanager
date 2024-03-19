import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:flutter/material.dart';

class ClientBridalMakeupHairCard extends StatelessWidget {
  const ClientBridalMakeupHairCard({super.key, required this.bridalMakeupAndHairEntity});
final BridalMakeupAndHairEntity bridalMakeupAndHairEntity;
 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.BridalMakeupAndHairDetailsScreen,arguments: bridalMakeupAndHairEntity);
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
                bridalMakeupAndHairEntity.images![0],
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
                    bridalMakeupAndHairEntity.name!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text('Capacity: ${bridalMakeupAndHairEntity.capacity}'),
                  Text('Contact: ${bridalMakeupAndHairEntity.contact}'),
                  ( bridalMakeupAndHairEntity.pricingInfo == null)
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
