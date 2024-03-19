import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeletePlannedEventsUsecase {
  final FirebaseRepository firebaseRepository;

  DeletePlannedEventsUsecase({required this.firebaseRepository});
  Future<void> call(String id) async {
    return await firebaseRepository.DeletePlannedEvents(id);
  }
}
