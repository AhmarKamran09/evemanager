part of 'clothing_cubit.dart';

sealed class ClothingState extends Equatable {
  const ClothingState();

  @override
  List<Object> get props => [];
}

final class ClothingInitial extends ClothingState {}
