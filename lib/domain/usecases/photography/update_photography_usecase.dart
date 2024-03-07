import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdatePhotographyUsecase {
  final FirebaseRepository firebaseRepository;

  UpdatePhotographyUsecase({required this.firebaseRepository});

  Future<void> call(PhotographyEntity photographyEntity) async {
    return await firebaseRepository.UpdatePhotography(photographyEntity);
  }

}
