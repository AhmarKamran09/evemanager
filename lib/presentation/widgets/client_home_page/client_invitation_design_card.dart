
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:flutter/material.dart';

class ClientInvitationDesignCard extends StatelessWidget {
  const ClientInvitationDesignCard({Key? key, required this.invitationDesignEntity});
  final InvitationDesignEntity invitationDesignEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageNames.InvitationDesignDetailsScreen, arguments: invitationDesignEntity);
      },
      child: Card(),
    );
  }
}
