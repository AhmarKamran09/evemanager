import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository firebaseRepository;

  SignInUsecase({required this.firebaseRepository});

  Future<bool> call(UserEntity user) async {
     return await firebaseRepository.SignInUser(user);
  }
}
