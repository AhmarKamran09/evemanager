import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';

class MessageModel extends MessageEntity {
  final bool seen;
  final String senderid;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.seen,
    required this.timestamp,
    required this.senderid,
  }) : super(
          seen: seen,
          message: message,
          timestamp: timestamp,
          senderid: senderid,
        );

  factory MessageModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MessageModel(
      seen: snap['seen'],
      senderid: snap['senderid'],
      timestamp: snap['timestamp'],
      message: snap['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'seen': seen,
        'senderid': senderid,
        'timestamp': timestamp,
        'message': message,
      };

  @override
  List<Object?> get props => [
        seen,
        message,
        senderid,
        timestamp,
      ];
}
