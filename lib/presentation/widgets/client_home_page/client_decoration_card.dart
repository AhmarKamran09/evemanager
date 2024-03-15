import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:flutter/material.dart';

class ClientDecorationCard extends StatelessWidget {
  const ClientDecorationCard({Key? key, required this.decorationEntity});
  final DecorationsEntity decorationEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.DecorationDetailsScreen, arguments: decorationEntity);
      },
      child: Card(),
    );
  }
}
