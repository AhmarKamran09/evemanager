import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderid;
  final String message;
  final Timestamp timestamp;

  MessageEntity({
    required this.message,
    required this.timestamp,
    required this.senderid,
  });

  @override
  List<Object?> get props => [
        message,
        senderid,
        timestamp,
      ];
}
