import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateVideographyUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateVideographyUsecase({required this.firebaseRepository});

  Future<void> call(VideographyEntity videographyEntity) async {
    return await firebaseRepository.UpdateVideography(videographyEntity);
  }

}
