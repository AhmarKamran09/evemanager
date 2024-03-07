import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateClothingUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateClothingUsecase({required this.firebaseRepository});

  Future<void> call(ClothingEntity clothingEntity) async {
    return await firebaseRepository.UpdateClothing(clothingEntity);
  }

}
