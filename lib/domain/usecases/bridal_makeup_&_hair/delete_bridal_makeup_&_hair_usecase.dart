import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteBridalMakeupAndHairUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteBridalMakeupAndHairUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteBridalMakeupAndHair(id);
  }
}
