part of 'rating_cubit.dart';

sealed class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {
  @override
  List<Object> get props => [];
}

final class RatingSuccess extends RatingState {
  final double ratingvalue;
  final String serviceId;

  RatingSuccess({required this.serviceId, required this.ratingvalue});
  @override
  List<Object> get props => [ratingvalue, serviceId];
}

final class AddRatingSuccess extends RatingState {
  AddRatingSuccess();
  @override
  List<Object> get props => [];
}

final class RatingFailure extends RatingState {
  @override
  List<Object> get props => [];
}

final class RatingLoading extends RatingState {
  @override
  List<Object> get props => [];
}
