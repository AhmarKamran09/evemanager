part of 'entertainment_cubit.dart';

sealed class EntertainmentState extends Equatable {
  const EntertainmentState();

  @override
  List<Object> get props => [];
}

final class EntertainmentInitial extends EntertainmentState {}

final class EntertainmentSuccess extends EntertainmentState {
  final List<EntertainmentEntity>? entertainment_entity;

  EntertainmentSuccess({this.entertainment_entity});

  @override
  List<Object> get props => [];
}

final class EntertainmentSuccessForClient extends EntertainmentState {
  final List<EntertainmentEntity>? entertainment_entity;

  EntertainmentSuccessForClient({required this.entertainment_entity});

  @override
  List<Object> get props => [];
}

final class EntertainmentSuccessForOwner extends EntertainmentState {
  final List<EntertainmentEntity>? entertainment_entity;

  EntertainmentSuccessForOwner({required this.entertainment_entity});

  @override
  List<Object> get props => [];
}

final class EntertainmentFailure extends EntertainmentState {
  @override
  List<Object> get props => [];
}

final class EntertainmentLoading extends EntertainmentState {
  @override
  List<Object> get props => [];
}
