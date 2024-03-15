import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:flutter/material.dart';

class ClientClothingCard extends StatelessWidget {
  const ClientClothingCard({super.key, required this.clothingEntity});
final ClothingEntity clothingEntity;
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.ClothngDetailsScreen, arguments: clothingEntity);
      },
      child: Card(),
    );
   }
}