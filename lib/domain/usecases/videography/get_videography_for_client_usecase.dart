import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetVideographyForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetVideographyForClientUsecase({required this.firebaseRepository});

  Stream<List<VideographyEntity>> call()  {
    return  firebaseRepository.GetVideographyforClient();
  }
}