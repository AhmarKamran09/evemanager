import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteVideographyUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteVideographyUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteVideography(id);
  }
}
