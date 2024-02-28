import 'package:evemanager/domain/repository/firebase_repository.dart';

class EditAvailabilityOfHallUsecase {
  final FirebaseRepository firebaseRepository;

  EditAvailabilityOfHallUsecase({required this.firebaseRepository});

  Future<void> call(String id, Map<String, bool> availability) async {
    return await firebaseRepository.EditAvailabilityOfHall(id, availability);
  }
}
