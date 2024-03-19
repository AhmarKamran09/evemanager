import 'package:equatable/equatable.dart';

class PlannedEventEntity extends Equatable {
  final String eventid;
  final String userid;
  final bool venue;
  final bool bridalmakeupandhair;
  final bool catering;
  final bool clothing;
  final bool decorations;
  final bool entertainment;
  final bool invitation_design;
  final bool photography;
  final bool sweets;
  final bool transportation;
  final bool videography;

  PlannedEventEntity({
    required this.eventid,
    required this.userid,
    required this.bridalmakeupandhair,
    required this.catering,
    required this.clothing,
    required this.decorations,
    required this.entertainment,
    required this.invitation_design,
    required this.photography,
    required this.sweets,
    required this.transportation,
    required this.videography,
    required this.venue,
  });

  @override
  List<Object?> get props => [
        eventid,
        userid,
        bridalmakeupandhair,
        catering,
        clothing,
        decorations,
        entertainment,
        invitation_design,
        photography,
        videography,
        sweets,
        transportation,
        venue
      ];
}
