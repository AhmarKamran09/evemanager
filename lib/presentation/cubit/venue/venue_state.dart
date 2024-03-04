part of 'venue_cubit.dart';

sealed class VenueState extends Equatable {
  const VenueState();

  @override
  List<Object> get props => [];
}

final class VenueInitial extends VenueState {
  @override
  List<Object> get props => [];
}

final class VenueSuccess extends VenueState {
  final List<VenueEntity>? VenueEntities;

  VenueSuccess({this.VenueEntities});
  @override
  List<Object> get props => [];
}

final class VenueSuccessForOwner extends VenueState {
  final List<VenueEntity>? VenueEntities;

  VenueSuccessForOwner({required this.VenueEntities});
  @override
  List<Object> get props => [];
}

final class VenueSuccessForClient extends VenueState {
  final List<VenueEntity>? VenueEntities;

  VenueSuccessForClient({required this.VenueEntities});
  @override
  List<Object> get props => [];
}

final class VenueFailure extends VenueState {
  @override
  List<Object> get props => [];
}

final class VenueLoading extends VenueState {
  @override
  List<Object> get props => [];
}
