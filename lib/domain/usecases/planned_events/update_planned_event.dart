import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdatePlannedEventsUsecase {
  final FirebaseRepository firebaseRepository;

  UpdatePlannedEventsUsecase({required this.firebaseRepository});

  // Future<void> call(PlannedEventEntity plannedEventEntity) async {
  //   return await firebaseRepository.UpdatePlannedEvents(plannedEventEntity);
  // }
}
