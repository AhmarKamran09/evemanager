import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteClothingUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteClothingUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteClothing(id);
  }
}
