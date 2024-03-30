import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetMessagesUsecase {
  final FirebaseRepository firebaseRepository;

  GetMessagesUsecase({required this.firebaseRepository});

  Stream<List<MessageEntity>> call(
      {required ChatEntity chatEntity, required UserRole userRole,
    required String request_sender_id,
 }) {
    return firebaseRepository.GetMessages(request_sender_id: request_sender_id,
        chatEntity: chatEntity, userRole: userRole);
  }
}
