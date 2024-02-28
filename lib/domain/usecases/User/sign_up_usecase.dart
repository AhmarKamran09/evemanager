import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class SignUpUserUsecase {
  final FirebaseRepository firebaseRepository;

  SignUpUserUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.SignUpUser(user);
  }
}
