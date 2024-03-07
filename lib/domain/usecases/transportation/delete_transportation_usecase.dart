import 'package:evemanager/domain/repository/firebase_repository.dart';

class DeleteTransportationUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteTransportationUsecase({required this.firebaseRepository});

  Future<void> call(String id) async {
    return await firebaseRepository.DeleteTransportation(id);
  }
}
