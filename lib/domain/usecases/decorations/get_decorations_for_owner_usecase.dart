import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetDecorationsForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetDecorationsForOwnerUsecase({required this.firebaseRepository});

  Stream<List<DecorationsEntity>> call(String ownerid)  {
    return  firebaseRepository.GetDecorationsforOwner(ownerid);
  }
}
