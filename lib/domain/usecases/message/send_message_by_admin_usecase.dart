import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class SendMessageByAdminUsecase {
  final FirebaseRepository firebaseRepository;

  SendMessageByAdminUsecase({required this.firebaseRepository});

  // Future<void> call(MessageEntity messageEntity) async {
  //   return await firebaseRepository.SendMessageByClient(messageEntity);
  // }
}
