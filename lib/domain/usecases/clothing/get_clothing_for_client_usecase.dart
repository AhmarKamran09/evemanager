import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetClothingForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetClothingForClientUsecase({required this.firebaseRepository});

  Stream<List<ClothingEntity>> call()  {
    return  firebaseRepository.GetClothingforClient();
  }
}