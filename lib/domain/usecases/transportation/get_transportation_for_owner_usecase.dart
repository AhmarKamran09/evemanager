import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetTransportationForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetTransportationForOwnerUsecase({required this.firebaseRepository});

  Stream<List<TransportationEntity>> call(String ownerid)  {
    return  firebaseRepository.GetTransportationforOwner(ownerid);
  }
}
