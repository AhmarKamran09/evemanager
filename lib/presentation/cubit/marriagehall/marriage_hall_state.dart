part of 'marriage_hall_cubit.dart';

sealed class MarriageHallState extends Equatable {
  const MarriageHallState();

  @override
  List<Object> get props => [];
}

final class MarriageHallInitial extends MarriageHallState {
  @override
  List<Object> get props => [];
}

final class MarriageHallSuccess extends MarriageHallState {
  final List<MarriageHallEntity>? marriageHallEntities;

  MarriageHallSuccess({this.marriageHallEntities});
  @override
  List<Object> get props => [];
}

final class MarriageHallSuccessForOwner extends MarriageHallState {
  final List<MarriageHallEntity>? marriageHallEntities;

  MarriageHallSuccessForOwner({required this.marriageHallEntities});
  @override
  List<Object> get props => [];
}
final class MarriageHallSuccessForClient extends MarriageHallState {
  final List<MarriageHallEntity>? marriageHallEntities;

  MarriageHallSuccessForClient({required this.marriageHallEntities});
  @override
  List<Object> get props => [];
}

final class MarriageHallFailure extends MarriageHallState {
  @override
  List<Object> get props => [];
}

final class MarriageHallLoading extends MarriageHallState {
  @override
  List<Object> get props => [];
}
