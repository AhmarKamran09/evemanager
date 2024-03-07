import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetDecorationsForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetDecorationsForClientUsecase({required this.firebaseRepository});

  Stream<List<DecorationsEntity>> call()  {
    return  firebaseRepository.GetDecorationsforClient();
  }
}