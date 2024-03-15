import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:flutter/material.dart';

class VideographyDetailsScreen extends StatelessWidget {
  const VideographyDetailsScreen({Key? key, required this.videographyEntity});
  final VideographyEntity videographyEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videography Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Add your UI components here to display details about the videography entity
        ],
      ),
    );
  }
}
