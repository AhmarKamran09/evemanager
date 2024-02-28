import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetMarriageHallForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetMarriageHallForClientUsecase({required this.firebaseRepository});

  Stream<List<MarriageHallEntity>> call()  {
    return  firebaseRepository.GetMarriageHallforClient();
  }
}
