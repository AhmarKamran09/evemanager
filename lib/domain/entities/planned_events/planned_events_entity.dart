import 'package:equatable/equatable.dart';

class PlannedEventEntity extends Equatable {
  final String eventid;
  final String userid;
  final bool venue;
  final bool catering;
  final bool decorations;
  final bool entertainment;
  final bool photography;
  final bool sweets;
  final bool videography;

  PlannedEventEntity({
    required this.eventid,
    required this.userid,
    required this.catering,
    required this.decorations,
    required this.entertainment,
    required this.photography,
    required this.sweets,
    required this.videography,
    required this.venue,
  });

  @override
  List<Object?> get props => [
        eventid,
        userid,
        catering,
        decorations,
        entertainment,
        photography,
        videography,
        sweets,
        venue
      ];
}
