import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetMessagesUsecase {
  final FirebaseRepository firebaseRepository;

  GetMessagesUsecase({required this.firebaseRepository});

  Stream<List<MessageEntity>> call(
      {required ChatEntity chatEntity, required UserRole userRole}) {
    return firebaseRepository.GetMessages(
        chatEntity: chatEntity, userRole: userRole);
  }
}
