import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetChatsUsecase {
  final FirebaseRepository firebaseRepository;

  GetChatsUsecase({required this.firebaseRepository});

  Stream<List<ChatEntity>> call(String  userid) {
    return firebaseRepository.GetChats(userid);
  }
}
