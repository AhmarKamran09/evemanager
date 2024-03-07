import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteDecorationsUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteDecorationsUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteDecorations(id);
  }
}
