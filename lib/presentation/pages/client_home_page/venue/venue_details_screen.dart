import 'package:flutter/material.dart';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue Details'),
        centerTitle: true,
      ),
    );
  }
}
