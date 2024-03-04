import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddVenueUsecase {
  final FirebaseRepository firebaseRepository;

  AddVenueUsecase({required this.firebaseRepository});

  Future<void> call(VenueEntity venueEntity) async {
    return await firebaseRepository.AddVenue(venueEntity);
  }
}
