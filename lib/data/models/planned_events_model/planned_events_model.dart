import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';

class PlannedEventModel extends PlannedEventEntity {
  final String eventid;
  final String userid;
  final bool venue;
  final bool catering;
  final bool decorations;
  final bool entertainment;
  final bool photography;
  final bool sweets;
  final bool videography;
  PlannedEventModel({
    required this.eventid,
    required this.userid,
    required this.catering,
    required this.decorations,
    required this.entertainment,
    required this.photography,
    required this.sweets,
    required this.videography,
    required this.venue,
  }) : super(
          eventid: eventid,
          userid: userid,
          catering: catering,
          decorations: decorations,
          entertainment: entertainment,
          photography: photography,
          sweets: sweets,
          videography: videography,
          venue: venue,
        );

  factory PlannedEventModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PlannedEventModel(
      eventid: snap['eventid'],
      userid: snap['userid'],
      catering: snap['catering'],
      decorations: snap['decorations'],
      entertainment: snap['entertainment'],
      photography: snap['photography'],
      sweets: snap['sweets'],
      venue: snap['venue'],
      videography: snap['videography'],
    );
  }

  Map<String, dynamic> toJson() => {
        'eventid': eventid,
        'userid': userid,
        'catering': catering,
        'decorations': decorations,
        'entertainment': entertainment,
        'photography': photography,
        'videography': videography,
        'sweets': sweets,
        'venue': venue,
      };

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
