import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateEntertainmentUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateEntertainmentUsecase({required this.firebaseRepository});

  Future<void> call(EntertainmentEntity entertainmentEntity) async {
    return await firebaseRepository.UpdateEntertainment(entertainmentEntity);
  }

}
