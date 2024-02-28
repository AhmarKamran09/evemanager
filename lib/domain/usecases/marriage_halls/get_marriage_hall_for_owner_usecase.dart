import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetMarriageHallForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetMarriageHallForOwnerUsecase({required this.firebaseRepository});

  Stream<List<MarriageHallEntity>> call(String ownerid)  {
    return  firebaseRepository.GetMarriageHallforOwner(ownerid);
  }
}
