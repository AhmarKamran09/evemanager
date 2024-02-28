import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteUserUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteUserUsecase({required this.firebaseRepository});

  Future<void> call({required String uid}) async {
    return await firebaseRepository.DeleteUser(uid);
  }
}
