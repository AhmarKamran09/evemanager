import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/chat/chat_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenAdmin extends StatelessWidget {
  const ChatScreenAdmin({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<ChatCubit>(context)
              .GetChatsForAdmin(userid: uid);
        },
        child: FutureBuilder(
          future:
              BlocProvider.of<ChatCubit>(context).GetChatsForAdmin(userid: uid),
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
                                    'uid': uid,
                                    'userrole': UserRole.admin
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  state.chatEntity[index].servicename,
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
      ),
    );
  }
}
