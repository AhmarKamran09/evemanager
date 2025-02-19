import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final int unseenMessagesByClient;
  final int unseenMessagesByAdmin;
  final String user1id;
  final String user2id_serviceowner;
  final String serviceid;
  final String servicename;

  ChatEntity({
    required this.unseenMessagesByAdmin,
    required this.unseenMessagesByClient,
    required this.servicename,
    required this.user1id,
    required this.user2id_serviceowner,
    required this.serviceid,
  });

  @override
  List<Object?> get props => [
        unseenMessagesByAdmin,
        unseenMessagesByClient,
        servicename,
        user1id,
        user2id_serviceowner,
        serviceid,
      ];
}
