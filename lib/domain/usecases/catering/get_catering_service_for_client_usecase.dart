import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetCateringServiceForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetCateringServiceForClientUsecase({required this.firebaseRepository});

  Stream<List<CateringEntity>> call()  {
    return  firebaseRepository.GetCateringServiceforClient();
  }
}