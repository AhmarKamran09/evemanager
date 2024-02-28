import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateCateringServiceUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateCateringServiceUsecase({required this.firebaseRepository});

  Future<void> call(CateringEntity cateringEntity) async {
    return await firebaseRepository.UpdateCateringService(cateringEntity);
  }
}
