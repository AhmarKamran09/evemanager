import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:flutter/material.dart';

class ClientCateringCard extends StatelessWidget {
  ClientCateringCard({super.key, required this.catering});
  final CateringEntity catering;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.CateringDetailsScreen,
            arguments: catering);
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
                catering.images![0],
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
                    catering.name!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Contact: ${catering.contact}'),
                  (catering.pricingInfo == null)
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
