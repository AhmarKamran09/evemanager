import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/cubit/messages/messages_cubit.dart';
import 'package:evemanager/presentation/cubit/rating/rating_cubit.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  double _rating = 3.0;

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
          return _body(context, _rating);
      },
    );
  }

  Widget _body(BuildContext context, double _rating) {
    return BlocListener<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state is AddRatingSuccess) {
          DisplayToast('Thanks For The Feedback');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Venue Details'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
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
                                      // print('object');
                                      BlocProvider.of<MessagesCubit>(context)
                                          .SendMessages(
                                        request_sender_id: widget.userid,
                                        userRole: UserRole.client,
                                        chatEntity: ChatEntity(
                                            unseenMessagesByAdmin: 1,
                                            unseenMessagesByClient: 0,
                                            servicename:
                                                widget.venueEntity.name!,
                                            user1id: widget.userid,
                                            user2id_serviceowner:
                                                widget.venueEntity.owner_id!,
                                            serviceid: widget.venueEntity.id!),
                                        clientid: widget.userid,
                                        messageEntity: MessageEntity(
                                            seen: false,
                                            message: message_controller.text,
                                            timestamp: Timestamp.now(),
                                            senderid: widget.userid),
                                        serviceEntity: ServiceEntity(
                                            id: widget.venueEntity.id,
                                            owner_id:
                                                widget.venueEntity.owner_id,
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
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Message'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RatingBar.builder(
                                initialRating: _rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            IconButton(
                                onPressed: () {
                                  // print('object');
                                  BlocProvider.of<RatingCubit>(context)
                                      .addRating(RatingEntity(
                                          rating: _rating,
                                          serviceId: widget.venueEntity.id));

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
                child: Text('Rate Us')),
          ],
        ),
      ),
    );
  }
}
