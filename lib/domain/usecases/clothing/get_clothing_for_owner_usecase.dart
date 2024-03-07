import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetClothingForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetClothingForOwnerUsecase({required this.firebaseRepository});

  Stream<List<ClothingEntity>> call(String ownerid)  {
    return  firebaseRepository.GetClothingforOwner(ownerid);
  }
}
