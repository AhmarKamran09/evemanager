import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddEntertainmentUsecase {
  final FirebaseRepository firebaseRepository;

  AddEntertainmentUsecase({required this.firebaseRepository});

  Future<void> call(EntertainmentEntity entertainmentEntity) async {
    return await firebaseRepository.AddEntertainment(entertainmentEntity);
  }
}
