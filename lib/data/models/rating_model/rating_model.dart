import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';

class RatingModel extends RatingEntity {
  final int? totalreviews;
  final String? serviceId;
  final double? rating;

  RatingModel({
    this.serviceId,
    this.rating,
    this.totalreviews,
  }) : super(
            serviceId: serviceId,
            rating: rating,
            totalreviews: totalreviews,);

  factory RatingModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return RatingModel(
      serviceId: snap['serviceId'],
      rating: snap['rating'],
      totalreviews: snap['totalreviews'],
    );
  }

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'rating': rating,
        'totalreviews': totalreviews,
      };

  @override
  List<Object?> get props => [
        serviceId,
        rating,
        totalreviews,
      ];
}
