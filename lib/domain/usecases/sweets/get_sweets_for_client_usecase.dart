import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetSweetsForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetSweetsForClientUsecase({required this.firebaseRepository});

  Stream<List<SweetEntity>> call()  {
    return  firebaseRepository.GetSweetsforClient();
  }
}