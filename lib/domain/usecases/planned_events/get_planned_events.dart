import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetPlannedEventsUsecase {
  final FirebaseRepository firebaseRepository;

  GetPlannedEventsUsecase({required this.firebaseRepository});

  Stream<List<PlannedEventEntity>> call(String userid) {
    return firebaseRepository.GetPlannedEvents(userid);
  }
}
