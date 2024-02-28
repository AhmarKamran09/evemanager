import 'package:evemanager/domain/repository/firebase_repository.dart';

class IsSignInUsecase {
  final FirebaseRepository firebaseRepository;

  IsSignInUsecase({required this.firebaseRepository});

  Future<bool> call() async {
    return await firebaseRepository.IsSignInUser();
  }
}
