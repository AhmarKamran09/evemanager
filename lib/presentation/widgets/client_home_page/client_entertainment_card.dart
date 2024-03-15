import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:flutter/material.dart';

class ClientEntertainmentCard extends StatelessWidget {
  const ClientEntertainmentCard({Key? key, required this.entertainmentEntity});
  final EntertainmentEntity entertainmentEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.EntertainmentDetailsScreen,
            arguments: entertainmentEntity);
      },
      child: Card(),
    );
  }
}
