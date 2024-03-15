import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:flutter/material.dart';

class InvitationDesignDetailsScreen extends StatelessWidget {
  const InvitationDesignDetailsScreen({Key? key, required this.invitationDesignEntity});
  final InvitationDesignEntity invitationDesignEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitation Design Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              // Show images in horizontal scroll in full screen mode
            },
            child: Container(
              margin: EdgeInsets.all(16),
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: invitationDesignEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: invitationDesignEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            invitationDesignEntity.images![index],
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No images'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
