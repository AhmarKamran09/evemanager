import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:flutter/material.dart';

class UpdateCateringScreen extends StatelessWidget {
  const UpdateCateringScreen({super.key, required this.cateringEntity});
final CateringEntity cateringEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Catering Service'),
      ),
    );
  }
}
