import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:flutter/material.dart';

class SweetsDetailsScreen extends StatelessWidget {
  const SweetsDetailsScreen({Key? key, required this.sweetsEntity});
  final SweetEntity sweetsEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sweets Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Add your UI components here to display details about the sweets entity
        ],
      ),
    );
  }
}
