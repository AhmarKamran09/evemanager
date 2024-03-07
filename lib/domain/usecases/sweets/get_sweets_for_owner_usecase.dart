import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetSweetsForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetSweetsForOwnerUsecase({required this.firebaseRepository});

  Stream<List<SweetEntity>> call(String ownerid)  {
    return  firebaseRepository.GetSweetsforOwner(ownerid);
  }
}
