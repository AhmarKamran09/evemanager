import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:flutter/material.dart';

class ClientVideographyCard extends StatelessWidget {
  const ClientVideographyCard({Key? key, required this.videographyEntity});
  final VideographyEntity videographyEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.VideographyDetailsScreen, arguments: videographyEntity);
      },
      child: Card(),
    );
  }
}
