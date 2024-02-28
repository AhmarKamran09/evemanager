import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateMarriageHallUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateMarriageHallUsecase({required this.firebaseRepository});

  Future<void> call(MarriageHallEntity marriageHallEntity) async {
    return await firebaseRepository.UpdateMarriageHall(marriageHallEntity);
  }
}
