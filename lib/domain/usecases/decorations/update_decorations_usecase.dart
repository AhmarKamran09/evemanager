import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateDecorationsUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateDecorationsUsecase({required this.firebaseRepository});

  Future<void> call(DecorationsEntity decorationsEntity) async {
    return await firebaseRepository.UpdateDecorations(decorationsEntity);
  }

}
