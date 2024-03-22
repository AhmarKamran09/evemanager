import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/cubit/messages/messages_cubit.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueDetailsScreen extends StatefulWidget {
  VenueDetailsScreen(
      {super.key, required this.venueEntity, required this.userid});
  final VenueEntity venueEntity;
  final String userid;

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  final TextEditingController message_controller = TextEditingController();
  final TextEditingController wedding_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // List<File> selectedImages = [];
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        if (state is MessagesSuccess) {
          DisplayToast('Message Sent Successfully');
        } else if (state is MessagesFailure) {
          DisplayToast('Message Not Sent. Some Error Ocurred!');
        }
      },
      builder: (context, state) {
        if (state is MessagesLoading) {
          return LoadingScreen();
        } else
          return _body(context);
      },
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue Details'),
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
              child: widget.venueEntity.images?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: widget.venueEntity.images?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            widget.venueEntity.images![index],
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
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Message'),
                            content: Column(
                              children: [
                                TextField(
                                  controller: message_controller,
                                ),
                                // TextField(

                                //   controller: wedding_controller,
                                // )
                              ],
                            ),
                            actions: <Widget>[
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.of(context)
                              //         .pop(); // Close the dialog
                              //   },
                              //   child: Text('Close'),
                              // ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<MessagesCubit>(context)
                                        .SendMessages(
                                      userRole: UserRole.client,
                                      chatEntity: ChatEntity(
                                          servicename: widget.venueEntity.name!,
                                          user1id: widget.userid,
                                          user2id_serviceowner:
                                              widget.venueEntity.owner_id!,
                                          serviceid: widget.venueEntity.id!),
                                      clientid: widget.userid,
                                      messageEntity: MessageEntity(
                                          message: message_controller.text,
                                          timestamp: Timestamp.now(),
                                          senderid: widget.userid),
                                      serviceEntity: ServiceEntity(
                                          id: widget.venueEntity.id,
                                          owner_id: widget.venueEntity.owner_id,
                                          name: widget.venueEntity.name),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.done)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.close))
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.message)),
              TextButton(onPressed: () {}, child: Text('Book Now '))
            ],
          )
        ],
      ),
    );
  }
}
