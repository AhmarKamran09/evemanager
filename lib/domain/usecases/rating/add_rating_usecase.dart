import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddRatingUsecase {
  final FirebaseRepository firebaseRepository;

  AddRatingUsecase({required this.firebaseRepository});

  Future<void> call(RatingEntity ratingEntity) async {
    return await firebaseRepository.AddRating(ratingEntity);
  }
}
