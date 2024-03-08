part of 'bridal_makeup_hair_cubit.dart';

sealed class BridalMakeupHairState extends Equatable {
  const BridalMakeupHairState();

  @override
  List<Object> get props => [];
}

final class BridalMakeupHairInitial extends BridalMakeupHairState {}

final class BridalMakeupHairSuccess extends BridalMakeupHairState {
  final List<BridalMakeupAndHairEntity>? bridal_makeup_entity;

  BridalMakeupHairSuccess({this.bridal_makeup_entity});

  @override
  List<Object> get props => [];
}

final class BridalMakeupHairSuccessForClient extends BridalMakeupHairState {
  final List<BridalMakeupAndHairEntity>? bridal_makeup_entity;

  BridalMakeupHairSuccessForClient({required this.bridal_makeup_entity});
  @override
  List<Object> get props => [];
}

final class BridalMakeupHairSuccessForOwner extends BridalMakeupHairState {
  final List<BridalMakeupAndHairEntity>? bridal_makeup_entity;

  BridalMakeupHairSuccessForOwner({required this.bridal_makeup_entity});
  @override
  List<Object> get props => [];
}

final class BridalMakeupHairFailure extends BridalMakeupHairState {
  @override
  List<Object> get props => [];
}

final class BridalMakeupHairLoading extends BridalMakeupHairState {
  @override
  List<Object> get props => [];
}
