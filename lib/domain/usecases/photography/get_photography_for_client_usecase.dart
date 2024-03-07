import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetPhotographyForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetPhotographyForClientUsecase({required this.firebaseRepository});

  Stream<List<PhotographyEntity>> call()  {
    return  firebaseRepository.GetPhotographyforClient();
  }
}