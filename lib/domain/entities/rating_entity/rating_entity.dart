import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final int? totalreviews;
  final String? serviceId;
  final double? rating;

  RatingEntity({
    this.totalreviews,
    this.serviceId,
    this.rating,
  });

  @override
  List<Object?> get props => [
        totalreviews,
        serviceId,
        rating,
      ];
}
