import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddPlannedEventUsecase {
  final FirebaseRepository firebaseRepository;

  AddPlannedEventUsecase({required this.firebaseRepository});

  Future<void> call(PlannedEventEntity plannedEventEntity) async {
    return await firebaseRepository.AddPlannedEvents(plannedEventEntity);
  }
}
