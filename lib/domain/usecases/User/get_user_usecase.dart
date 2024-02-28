import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetUserUsecase {
  final FirebaseRepository firebaseRepository;

  GetUserUsecase({required this.firebaseRepository});

  Future<UserEntity> call({required String uid}) async {
    return await firebaseRepository.GetUser(uid);
  }
}
