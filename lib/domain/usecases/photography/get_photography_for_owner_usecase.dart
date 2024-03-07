import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetPhotographyForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetPhotographyForOwnerUsecase({required this.firebaseRepository});

  Stream<List<PhotographyEntity>> call(String ownerid)  {
    return  firebaseRepository.GetPhotographyforOwner(ownerid);
  }
}
