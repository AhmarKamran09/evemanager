part of 'photography_cubit.dart';

sealed class PhotographyState extends Equatable {
  const PhotographyState();

  @override
  List<Object> get props => [];
}

final class PhotographyInitial extends PhotographyState {}

final class PhotographySuccess extends PhotographyState {
  final List<PhotographyEntity>? photography_entity;

  PhotographySuccess({this.photography_entity});

  @override
  List<Object> get props => [];
}

final class PhotographySuccessForClient extends PhotographyState {
  final List<PhotographyEntity>? photography_entity;

  PhotographySuccessForClient({required this.photography_entity});

  @override
  List<Object> get props => [];
}

final class PhotographySuccessForOwner extends PhotographyState {
  final List<PhotographyEntity>? photography_entity;

  PhotographySuccessForOwner({required this.photography_entity});

  @override
  List<Object> get props => [];
}

final class PhotographyFailure extends PhotographyState {
  @override
  List<Object> get props => [];
}

final class PhotographyLoading extends PhotographyState {
  @override
  List<Object> get props => [];
}