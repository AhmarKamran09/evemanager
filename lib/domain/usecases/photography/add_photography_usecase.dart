import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddPhotographyUsecase {
  final FirebaseRepository firebaseRepository;

  AddPhotographyUsecase({required this.firebaseRepository});

  Future<void> call(PhotographyEntity photographyEntity) async {
    return await firebaseRepository.AddPhotography(photographyEntity);
  }
}
