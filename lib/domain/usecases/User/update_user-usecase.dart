import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateUserUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateUserUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.UpdateUser(user);
  }
}
