import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetBridalMakeupAndHairForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetBridalMakeupAndHairForOwnerUsecase({required this.firebaseRepository});

  Stream<List<BridalMakeupAndHairEntity>> call(String ownerid) {
    return firebaseRepository.GetBridalMakeupAndHairforOwner(ownerid);
  }
}
