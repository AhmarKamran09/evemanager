import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';

class MessageModel extends MessageEntity {
  final String senderid;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.timestamp,
    required this.senderid,
  }) : super(
          message: message,
          timestamp: timestamp,
          senderid: senderid,
        );

  factory MessageModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MessageModel(
      senderid: snap['senderid'],
      timestamp: snap['timestamp'],
      message: snap['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'senderid': senderid,
        'timestamp': timestamp,
        'message': message,
      };

  @override
  List<Object?> get props => [
        message,
        senderid,
        timestamp,
      ];
}
