import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddDecorationsUsecase {
  final FirebaseRepository firebaseRepository;

  AddDecorationsUsecase({required this.firebaseRepository});

  Future<void> call(DecorationsEntity decorationsEntity) async {
    return await firebaseRepository.AddDecorations(decorationsEntity);
  }
}
