import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetCateringServiceForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetCateringServiceForOwnerUsecase({required this.firebaseRepository});

  Stream<List<CateringEntity>> call(String ownerid)  {
    return  firebaseRepository.GetCateringServiceforOwner(ownerid);
  }
}
