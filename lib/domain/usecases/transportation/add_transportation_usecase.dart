import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddTransportationUsecase {
  final FirebaseRepository firebaseRepository;

  AddTransportationUsecase({required this.firebaseRepository});

  Future<void> call(TransportationEntity transportationEntity) async {
    return await firebaseRepository.AddTransportation(transportationEntity);
  }
}
