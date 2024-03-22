import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class SendMessageUsecase {
  final FirebaseRepository firebaseRepository;

  SendMessageUsecase({required this.firebaseRepository});

  Future<void> call(
      {required String clientid,
      required MessageEntity messageEntity,
      required ServiceEntity serviceEntity}) async {
    return await firebaseRepository.SendMessage(
        clientid: clientid,
        messageEntity: messageEntity,
        serviceEntity: serviceEntity);
  }
}
