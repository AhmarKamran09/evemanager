import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetMessagesUsecase {
  final FirebaseRepository firebaseRepository;

  GetMessagesUsecase({required this.firebaseRepository});

  Stream<List<MessageEntity>> call(ChatEntity chatEntity) {
    return firebaseRepository.GetMessages(chatEntity);
  }
}
