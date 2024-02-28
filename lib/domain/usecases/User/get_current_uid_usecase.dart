import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetCurrentUidUsecase {
  final FirebaseRepository firebaseRepository;

  GetCurrentUidUsecase({required this.firebaseRepository});

  Future<String?> call() async {
    return await firebaseRepository.GetCurrentUid();
  }
}
