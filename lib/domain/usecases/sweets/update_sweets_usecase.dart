import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateSweetsUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateSweetsUsecase({required this.firebaseRepository});

  Future<void> call(SweetEntity sweetEntity) async {
    return await firebaseRepository.UpdateSweets(sweetEntity);
  }

}
