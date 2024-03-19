import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String user1id;
  final String user2id_serviceowner;
  final String serviceid;
  final String servicename;

  ChatEntity({
    required this.servicename,
    required this.user1id,
    required this.user2id_serviceowner,
    required this.serviceid,
  });

  @override
  List<Object?> get props => [
        servicename,
        user1id,
        user2id_serviceowner,
        serviceid,
      ];
}
