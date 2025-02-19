import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';

class ChatModel extends ChatEntity {
  final String user1id;
  final int unseenMessagesByClient;
  final int unseenMessagesByAdmin;
  final String user2id_serviceowner;
  final String serviceid;
  final String servicename;

  ChatModel({
    required this.unseenMessagesByAdmin,
    required this.unseenMessagesByClient,
    required this.user1id,
    required this.user2id_serviceowner,
    required this.serviceid,
    required this.servicename,
  }) : super(
          unseenMessagesByAdmin: unseenMessagesByAdmin,
          unseenMessagesByClient: unseenMessagesByClient,
          servicename: servicename,
          user1id: user1id,
          user2id_serviceowner: user2id_serviceowner,
          serviceid: serviceid,
        );

  factory ChatModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return ChatModel(
      unseenMessagesByClient: snap['unseenMessagesByClient'],
      unseenMessagesByAdmin: snap['unseenMessagesByAdmin'],
      user1id: snap['user1id'],
      user2id_serviceowner: snap['user2id_serviceowner'],
      serviceid: snap['serviceid'],
      servicename: snap['servicename'],
    );
  }

  Map<String, dynamic> toJson() => {
        'unseenMessagesByClient': unseenMessagesByClient,
        'unseenMessagesByAdmin': unseenMessagesByAdmin,
        'user1id': user1id,
        'user2id_serviceowner': user2id_serviceowner,
        'serviceid': serviceid,
        'servicename': servicename,
      };

  @override
  List<Object?> get props => [
        unseenMessagesByAdmin,
        unseenMessagesByClient,
        user1id,
        user2id_serviceowner,
        serviceid,
        servicename,
      ];
}
