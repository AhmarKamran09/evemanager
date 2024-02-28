import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddCateringServiceUsecase {
  final FirebaseRepository firebaseRepository;

  AddCateringServiceUsecase({required this.firebaseRepository});

  Future<void> call(CateringEntity cateringEntity) async {
    return await firebaseRepository.AddCateringService(cateringEntity);
  }
}
