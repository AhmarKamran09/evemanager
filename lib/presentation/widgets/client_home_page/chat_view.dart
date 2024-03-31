import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/chat/chat_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.userid,
  });
  final String userid;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<ChatCubit>(context)
            .GetChatsForClient(userid: userid);
      },
      child: FutureBuilder(
        future: BlocProvider.of<ChatCubit>(context)
            .GetChatsForClient(userid: userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatFailure) {
                  DisplayToast('Chat loading failed');
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return LoadingBody();
                } else if (state is ChatSuccess) {
                  if (state.chatEntity.isNotEmpty) {
                    return ListView.builder(
                        itemCount: state.chatEntity.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageNames.MessagesScreen,
                                arguments: {
                                  'chatEntity': state.chatEntity[index],
                                  'uid': userid,
                                  'userrole': UserRole.client
                                },
                              );
                            },
                            child: ListTile(
                              title: Text(
                                state.chatEntity[index].servicename,
                              ),
                              subtitle: Text(state
                                  .chatEntity[index].unseenMessagesByClient==0?'all seen':'unseen'
                                  
                                  ),
                            ),
                          );
                        });
                  } else {
                    return Text('No Messages');
                  }
                } else {
                  return Text('Message Page');
                }
              },
            );
          } else {
            return LoadingBody();
          }
        },
      ),
    );
  }
}
//  return StreamBuilder<List<ChatEntity>>(
//                     stream: state.chatEntity,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return LoadingBody(); // or any loading indicator
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (!snapshot.hasData) {
//                         return Text('No data available');
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.done) {
//                         // Data is available, build your UI using the chat entities
//                         List<ChatEntity> chatEntities = snapshot.data!;
//                         return ListView.builder(
//                           itemCount: chatEntities.length,
//                           itemBuilder: (context, index) {
//                             print(chatEntities[index].servicename);
//                             print(chatEntities[index].user2id);
//                             // Build your UI for each chat entity
//                             return ListTile(
//                               title: Text(
//                                 chatEntities[index].servicename,
//                                 style: TextStyle(fontSize: 30),
//                               ),
//                               // subtitle: Text(chatEntities[index].),
//                               // Add more widgets as needed
//                             );
//                           },
//                         );
//                       } else {
//                         return LoadingBody();
//                       }
//                     },
//                   );
                