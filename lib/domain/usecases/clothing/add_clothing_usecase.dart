import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddClothingUsecase {
  final FirebaseRepository firebaseRepository;

  AddClothingUsecase({required this.firebaseRepository});

  Future<void> call(ClothingEntity clothingEntity) async {
    return await firebaseRepository.AddClothing(clothingEntity);
  }
}
