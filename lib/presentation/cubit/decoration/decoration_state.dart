part of 'decoration_cubit.dart';

sealed class DecorationState extends Equatable {
  const DecorationState();

  @override
  List<Object> get props => [];
}

final class DecorationInitial extends DecorationState {}

final class DecorationsSuccess extends DecorationState {
  final List<DecorationsEntity>? decorations_entity;

  DecorationsSuccess({this.decorations_entity});

  @override
  List<Object> get props => [];
}

final class DecorationsSuccessForClient extends DecorationState {
  final List<DecorationsEntity>? decorations_entity;

  DecorationsSuccessForClient({required this.decorations_entity});

  @override
  List<Object> get props => [];
}

final class DecorationsSuccessForOwner extends DecorationState {
  final List<DecorationsEntity>? decorations_entity;

  DecorationsSuccessForOwner({required this.decorations_entity});

  @override
  List<Object> get props => [];
}

final class DecorationsFailure extends DecorationState {
  @override
  List<Object> get props => [];
}

final class DecorationsLoading extends DecorationState {
  @override
  List<Object> get props => [];
}
