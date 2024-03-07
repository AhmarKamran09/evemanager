import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddSweetsUsecase {
  final FirebaseRepository firebaseRepository;

  AddSweetsUsecase({required this.firebaseRepository});

  Future<void> call(SweetEntity sweetEntity) async {
    return await firebaseRepository.AddSweets(sweetEntity);
  }
}
