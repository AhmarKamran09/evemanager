import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetVenueForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetVenueForOwnerUsecase({required this.firebaseRepository});

  Stream<List<VenueEntity>> call(String ownerid) {
    return firebaseRepository.GetVenueforOwner(ownerid);
  }
}
