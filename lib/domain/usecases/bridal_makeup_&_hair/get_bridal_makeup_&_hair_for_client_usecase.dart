import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetBridalMakeupAndHairForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetBridalMakeupAndHairForClientUsecase({required this.firebaseRepository});

  Stream<List<BridalMakeupAndHairEntity>> call() {
    return firebaseRepository.GetBridalMakeupAndHairforClient();
  }
}
