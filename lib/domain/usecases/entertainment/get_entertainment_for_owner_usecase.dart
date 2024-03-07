import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetEntertainmentForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetEntertainmentForOwnerUsecase({required this.firebaseRepository});

  Stream<List<EntertainmentEntity>> call(String ownerid)  {
    return  firebaseRepository.GetEntertainmentforOwner(ownerid);
  }
}
