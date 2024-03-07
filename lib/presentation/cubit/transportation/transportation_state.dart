part of 'transportation_cubit.dart';

sealed class TransportationState extends Equatable {
  const TransportationState();

  @override
  List<Object> get props => [];
}

final class TransportationInitial extends TransportationState {}
