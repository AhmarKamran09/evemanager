import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateBridalMakeupAndHairUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateBridalMakeupAndHairUsecase({required this.firebaseRepository});

  Future<void> call(BridalMakeupAndHairEntity bridalMakeupAndHairEntity) async {
    return await firebaseRepository.UpdateBridalMakeupAndHair(
        bridalMakeupAndHairEntity);
  }
}
