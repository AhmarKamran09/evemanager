import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetVideographyForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetVideographyForOwnerUsecase({required this.firebaseRepository});

  Stream<List<VideographyEntity>> call(String ownerid)  {
    return  firebaseRepository.GetVideographyforOwner(ownerid);
  }
}
