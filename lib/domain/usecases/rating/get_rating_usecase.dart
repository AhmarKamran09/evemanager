import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetRatingUsecase {
  final FirebaseRepository firebaseRepository;

  GetRatingUsecase({required this.firebaseRepository});

  Stream<List<RatingEntity>> call(String serviceId) {
    return firebaseRepository.GetRating(serviceId);
  }
}
