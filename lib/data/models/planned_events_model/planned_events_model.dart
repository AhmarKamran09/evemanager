import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';

class PlannedEventModel extends PlannedEventEntity {
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
  PlannedEventModel({
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
  }) : super(
          eventid: eventid,
          userid: userid,
          bridalmakeupandhair: bridalmakeupandhair,
          catering: catering,
          clothing: clothing,
          decorations: decorations,
          entertainment: entertainment,
          invitation_design: invitation_design,
          photography: photography,
          sweets: sweets,
          transportation: transportation,
          videography: videography,
          venue: venue,
        );

  factory PlannedEventModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PlannedEventModel(
      eventid: snap['eventid'],
      userid: snap['userid'],
      bridalmakeupandhair: snap['bridalmakeupandhair'],
      catering: snap['catering'],
      clothing: snap['clothing'],
      decorations: snap['decorations'],
      entertainment: snap['entertainment'],
      invitation_design: snap['invitation_design'],
      photography: snap['photography'],
      sweets: snap['sweets'],
      transportation: snap['transportation'],
      venue: snap['venue'],
      videography: snap['videography'],
    );
  }

  Map<String, dynamic> toJson() => {
        'eventid': eventid,
        'userid': userid,
        'bridalmakeupandhair': bridalmakeupandhair,
        'catering': catering,
        'clothing': clothing,
        'decorations': decorations,
        'entertainment': entertainment,
        'invitation_design': invitation_design,
        'photography': photography,
        'videography': videography,
        'sweets': sweets,
        'transportation': transportation,
        'venue': venue,
      };

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
