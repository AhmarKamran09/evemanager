import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetEntertainmentForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetEntertainmentForClientUsecase({required this.firebaseRepository});

  Stream<List<EntertainmentEntity>> call()  {
    return  firebaseRepository.GetEntertainmentforClient();
  }
}