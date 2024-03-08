part of 'transportation_cubit.dart';

sealed class TransportationState extends Equatable {
  const TransportationState();

  @override
  List<Object> get props => [];
}

final class TransportationInitial extends TransportationState {}
final class TransportationSuccess extends TransportationState {
  final List<TransportationEntity>? transportation_entity;

  TransportationSuccess({this.transportation_entity});

  @override
  List<Object> get props => [];
}

final class TransportationSuccessForClient extends TransportationState {
  final List<TransportationEntity>? transportation_entity;

  TransportationSuccessForClient({required this.transportation_entity});

  @override
  List<Object> get props => [];
}

final class TransportationSuccessForOwner extends TransportationState {
  final List<TransportationEntity>? transportation_entity;

  TransportationSuccessForOwner({required this.transportation_entity});

  @override
  List<Object> get props => [];
}

final class TransportationFailure extends TransportationState {
  @override
  List<Object> get props => [];
}

final class TransportationLoading extends TransportationState {
  @override
  List<Object> get props => [];
}
