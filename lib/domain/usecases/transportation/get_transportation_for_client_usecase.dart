import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetTransportationForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetTransportationForClientUsecase({required this.firebaseRepository});

  Stream<List<TransportationEntity>> call()  {
    return  firebaseRepository.GetTransportationforClient();
  }
}