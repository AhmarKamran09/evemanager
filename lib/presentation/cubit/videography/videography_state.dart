part of 'videography_cubit.dart';

sealed class VideographyState extends Equatable {
  const VideographyState();

  @override
  List<Object> get props => [];
}

final class VideographyInitial extends VideographyState {}
final class VideographySuccess extends VideographyState {
  final List<VideographyEntity>? videography_entity;

  VideographySuccess({this.videography_entity});

  @override
  List<Object> get props => [];
}

final class VideographySuccessForClient extends VideographyState {
  final List<VideographyEntity>? videography_entity;

  VideographySuccessForClient({required this.videography_entity});

  @override
  List<Object> get props => [];
}

final class VideographySuccessForOwner extends VideographyState {
  final List<VideographyEntity>? videography_entity;

  VideographySuccessForOwner({required this.videography_entity});

  @override
  List<Object> get props => [];
}

final class VideographyFailure extends VideographyState {
  @override
  List<Object> get props => [];
}

final class VideographyLoading extends VideographyState {
  @override
  List<Object> get props => [];
}