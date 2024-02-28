part of 'cateringservice_cubit.dart';

sealed class CateringserviceState extends Equatable {
  const CateringserviceState();

  @override
  List<Object> get props => [];
}

final class CateringserviceInitial extends CateringserviceState {
  @override
  List<Object> get props => [];
}

final class CateringserviceSuccess extends CateringserviceState {
  final List<CateringEntity>? catering_entities;

  CateringserviceSuccess({this.catering_entities});

  @override
  List<Object> get props => [];
}

final class CateringserviceSuccessForClient extends CateringserviceState {
  final List<CateringEntity>? catering_entities;

  CateringserviceSuccessForClient({required this.catering_entities});
  @override
  List<Object> get props => [];
}

final class CateringserviceSuccessForOwner extends CateringserviceState {
  final List<CateringEntity>? catering_entities;

  CateringserviceSuccessForOwner({required this.catering_entities});
  @override
  List<Object> get props => [];
}

final class CateringserviceFailure extends CateringserviceState {
  @override
  List<Object> get props => [];
}

final class CateringserviceLoading extends CateringserviceState {
  @override
  List<Object> get props => [];
}
