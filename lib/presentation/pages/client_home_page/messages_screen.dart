import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/presentation/cubit/messages/messages_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen(
      {super.key,
      required this.uid,
      required this.chatEntity,
      required this.userRole});
  final ChatEntity chatEntity;
  final String uid;
  final UserRole userRole;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController message_controller = TextEditingController();
  Widget? _successUI;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      await BlocProvider.of<MessagesCubit>(context).GetMessages(
          request_sender_id: widget.uid,
          chatEntity: widget.chatEntity,
          userRole: widget.userRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () async {
            await BlocProvider.of<MessagesCubit>(context).GetMessages(
                request_sender_id: widget.uid,
                chatEntity: widget.chatEntity,
                userRole: widget.userRole);
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<MessagesCubit>(context).GetMessages(
                request_sender_id: widget.uid,
                chatEntity: widget.chatEntity,
                userRole: widget.userRole);
          },
          child: BlocConsumer<MessagesCubit, MessagesState>(
            listener: (context, state) {
              if (state is MessagesFailure) {
                DisplayToast('failed in gettiing message');
              }
            },
            builder: (context, state) {
              if (state is MessagesSuccess) {
                if (state.messageEntity?.isNotEmpty ?? false) {
                  List<MessageEntity> messages =
                      state.messageEntity!.reversed.toList();
                  return _successUI = Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: state.messageEntity?.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(messages[index].message),
                                subtitle:
                                    Text(messages[index].timestamp.toString()),
                              );
                            }),
                      ),
                      Container(
                        color: lightBlue.withOpacity(0.1),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: message_controller,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                BlocProvider.of<MessagesCubit>(context)
                                    .SendMessages(
                                        request_sender_id: widget.uid,
                                        chatEntity: widget.chatEntity,
                                        userRole: widget.userRole,
                                        clientid: widget.chatEntity.user1id,
                                        messageEntity: MessageEntity(
                                            seen: false,
                                            message: message_controller.text,
                                            timestamp: Timestamp.now(),
                                            senderid: widget.uid),
                                        serviceEntity: ServiceEntity(
                                            owner_id: widget.chatEntity
                                                .user2id_serviceowner,
                                            id: widget.chatEntity.serviceid,
                                            name:
                                                widget.chatEntity.servicename));
                                message_controller.clear();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                } else {
                  return _successUI = Text('No Messages To Show');
                }
              } else {
                return _successUI != null ? _successUI! : LoadingBody();
              }
            },
          )),
    );
  }
}
