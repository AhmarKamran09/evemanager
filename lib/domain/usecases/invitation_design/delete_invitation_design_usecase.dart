import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteInvitationDesignUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteInvitationDesignUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteInvitationDesign(id);
  }
}
