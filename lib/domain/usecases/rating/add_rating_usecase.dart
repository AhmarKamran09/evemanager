import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddRatingUsecase {
  final FirebaseRepository firebaseRepository;

  AddRatingUsecase({required this.firebaseRepository});

  Future<void> call({required double rating,required String serviceId,required Firebase_enum firebase_enum} ) async {
    return await firebaseRepository.AddRating(rating: rating, serviceId: serviceId, firebase_enum: firebase_enum);
  }
}
