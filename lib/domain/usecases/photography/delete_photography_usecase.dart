import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeletePhotographyUsecase {
  final FirebaseRepository firebaseRepository;

  DeletePhotographyUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeletePhotography(id);
  }
}
