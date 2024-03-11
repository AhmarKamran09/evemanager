import 'package:flutter/material.dart';

class AddCateringScreen extends StatelessWidget {
  const AddCateringScreen({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Catering Service'),
        centerTitle: true,
      ),
    );
  }
}
