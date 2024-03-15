import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:flutter/material.dart';

class ClientPhotographyCard extends StatelessWidget {
  const ClientPhotographyCard({Key? key, required this.photographyEntity});
  final PhotographyEntity photographyEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.PhotographyDetailsScreen, arguments: photographyEntity);
      },
      child: Card(),
    );
  }
}
