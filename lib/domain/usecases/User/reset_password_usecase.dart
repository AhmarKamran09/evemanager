import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class ResetPasswordUsecase {
  final FirebaseRepository firebaseRepository;

  ResetPasswordUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.ResetPassword(user);
  }
}
