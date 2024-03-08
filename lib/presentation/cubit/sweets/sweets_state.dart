part of 'sweets_cubit.dart';

sealed class SweetsState extends Equatable {
  const SweetsState();

  @override
  List<Object> get props => [];
}

final class SweetsInitial extends SweetsState {}
final class SweetsSuccess extends SweetsState {
  final List<SweetEntity>? sweets_entity;

  SweetsSuccess({this.sweets_entity});

  @override
  List<Object> get props => [];
}

final class SweetsSuccessForClient extends SweetsState {
  final List<SweetEntity>? sweets_entity;

  SweetsSuccessForClient({required this.sweets_entity});

  @override
  List<Object> get props => [];
}

final class SweetsSuccessForOwner extends SweetsState {
  final List<SweetEntity>? sweets_entity;

  SweetsSuccessForOwner({required this.sweets_entity});

  @override
  List<Object> get props => [];
}


final class SweetsFailure extends SweetsState {
  @override
  List<Object> get props => [];
}

final class SweetsLoading extends SweetsState {
  @override
  List<Object> get props => [];
}