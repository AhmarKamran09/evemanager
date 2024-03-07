import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteSweetsUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteSweetsUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteSweets(id);
  }
}
