import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';

class RatingModel extends RatingEntity {
  final String? id;
  final String? serviceId;
  final double? rating;
  final String? comment;
  final DateTime? timestamp;
  final String? userid;

  RatingModel({
    this.serviceId,
    this.rating,
    this.comment,
    this.timestamp,
    this.userid,
    this.id,
  }) : super(
            serviceId: serviceId,
            rating: rating,
            comment: comment,
            timestamp: timestamp,
            userid: userid,
            id: id);

  factory RatingModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return RatingModel(
      serviceId: snap['serviceId'],
      rating: snap['rating'],
      comment: snap['comment'],
      timestamp: snap['timestamp'],
      userid: snap['userid'],
      id: snap['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'rating': rating,
        'comment': comment,
        'id': id,
        'timestamp': timestamp,
        'userid': userid,
      };

  @override
  List<Object?> get props => [
        serviceId,
        rating,
        comment,
        timestamp,
        userid,
        id,
      ];
}
