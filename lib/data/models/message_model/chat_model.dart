import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';

class ChatModel extends ChatEntity {
  final String user1id;
  final String user2id_serviceowner;
  final String serviceid;
  final String servicename;

  ChatModel({
    required this.user1id,
    required this.user2id_serviceowner,
    required this.serviceid,
    required this.servicename,
  }) : super(
          servicename: servicename,
          user1id: user1id,
          user2id_serviceowner: user2id_serviceowner,
          serviceid: serviceid,
        );

  factory ChatModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return ChatModel(
      user1id: snap['user1id'],
      user2id_serviceowner: snap['user2id_serviceowner'],
      serviceid: snap['serviceid'],
      servicename: snap['servicename'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user1id': user1id,
        'user2id_serviceowner': user2id_serviceowner,
        'serviceid': serviceid,
        'servicename': servicename,
      };

  @override
  List<Object?> get props => [
        user1id,
        user2id_serviceowner,
        serviceid,
        servicename,
      ];
}
