import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteEntertainmentUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteEntertainmentUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteEntertainment(id);
  }
}
