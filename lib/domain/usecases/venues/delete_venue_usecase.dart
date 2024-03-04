import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteVenueUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteVenueUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteVenue(id);
  }
}
