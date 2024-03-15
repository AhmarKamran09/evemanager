import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:flutter/material.dart';

class ClientTransportationCard extends StatelessWidget {
  const ClientTransportationCard({Key? key, required this.transportationEntity});
  final TransportationEntity transportationEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.TransportationDetailsScreen, arguments: transportationEntity);
      },
      child: Card(),
    );
  }
}
