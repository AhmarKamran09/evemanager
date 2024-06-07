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
 
  @override
  List<Object> get props => [ ];
}


final class RatingFailure extends RatingState {
  @override
  List<Object> get props => [];
}

final class RatingLoading extends RatingState {
  @override
  List<Object> get props => [];
}
