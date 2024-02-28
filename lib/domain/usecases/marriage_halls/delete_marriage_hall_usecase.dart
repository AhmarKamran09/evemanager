import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteMarriageHallUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteMarriageHallUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteMarriageHall(id);
  }
}
