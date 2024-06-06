import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetRatingUsecase {
  final FirebaseRepository firebaseRepository;

  GetRatingUsecase({required this.firebaseRepository});

 Future<double> call(String serviceId) {
    return firebaseRepository.GetRating(serviceId);
  }
}
