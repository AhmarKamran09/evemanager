import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateVenueUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateVenueUsecase({required this.firebaseRepository});

  Future<void> call(VenueEntity venueEntity) async {
    return await firebaseRepository.UpdateVenue(venueEntity);
  }
}
