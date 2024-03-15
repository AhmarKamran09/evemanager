import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:flutter/material.dart';

class ClientSweetsCard extends StatelessWidget {
  const ClientSweetsCard({Key? key, required this.sweetsEntity});
  final SweetEntity sweetsEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.SweetsDetailsScreen, arguments: sweetsEntity);
      },
      child: Card(),
    );
  }
}
