import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteCateringServiceUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteCateringServiceUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteCateringService(id);
  }
}
