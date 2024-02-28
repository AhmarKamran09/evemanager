import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddMarriageHallUsecase {
  final FirebaseRepository firebaseRepository;

  AddMarriageHallUsecase({required this.firebaseRepository});

  Future<void> call(MarriageHallEntity marriageHallEntity) async {
    return await firebaseRepository.AddMarriageHall(marriageHallEntity);
  }
}
