import 'package:evemanager/domain/repository/firebase_repository.dart';

class EditAvailabilityOfVenueUsecase {
  final FirebaseRepository firebaseRepository;

  EditAvailabilityOfVenueUsecase({required this.firebaseRepository});

  Future<void> call(String id, Map<String, bool> availability) async {
    return await firebaseRepository.EditAvailabilityOfVenue(id, availability);
  }
}
