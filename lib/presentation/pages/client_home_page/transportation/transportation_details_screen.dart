import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:flutter/material.dart';

class TransportationDetailsScreen extends StatelessWidget {
  const TransportationDetailsScreen({Key? key, required this.transportationEntity});
  final TransportationEntity transportationEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Add your UI components here to display details about the transportation entity
        ],
      ),
    );
  }
}
