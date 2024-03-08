part of 'clothing_cubit.dart';

sealed class ClothingState extends Equatable {
  const ClothingState();

  @override
  List<Object> get props => [];
}

final class ClothingInitial extends ClothingState {}


final class ClothingSuccess extends ClothingState {
  final List<ClothingEntity>? clothing_entity;

 ClothingSuccess({this.clothing_entity});

  @override
  List<Object> get props => [];
}

final class ClothingSuccessForClient extends ClothingState {
  final List<ClothingEntity>? clothing_entity;

  ClothingSuccessForClient({required this.clothing_entity});
  @override
  List<Object> get props => [];
}

final class ClothingSuccessForOwner extends ClothingState {
  final List<ClothingEntity>? clothing_entity;

  ClothingSuccessForOwner({required this.clothing_entity});
  @override
  List<Object> get props => [];
}

final class ClothingFailure extends ClothingState {
  @override
  List<Object> get props => [];
}

final class ClothingLoading extends ClothingState {
  @override
  List<Object> get props => [];
}

