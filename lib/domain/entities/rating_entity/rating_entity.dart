import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final String? id;
  final String? serviceId;
  final double? rating;
  final String? comment;
  final DateTime? timestamp;
  final String? userid;

  RatingEntity({
    this.id,
    this.userid,
    this.serviceId,
    this.rating,
    this.comment,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        userid,
        serviceId,
        rating,
        comment,
        timestamp,
      ];
}
