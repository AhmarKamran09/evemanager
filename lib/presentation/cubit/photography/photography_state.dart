part of 'photography_cubit.dart';

sealed class PhotographyState extends Equatable {
  const PhotographyState();

  @override
  List<Object> get props => [];
}

final class PhotographyInitial extends PhotographyState {}
