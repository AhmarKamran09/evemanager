import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetVenueForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetVenueForClientUsecase({required this.firebaseRepository});

  Stream<List<VenueEntity>> call() {
    return firebaseRepository.GetVenueforClient();
  }
}
