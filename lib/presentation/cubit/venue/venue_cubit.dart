import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/usecases/venues/add_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/delete_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/venues/update_venue_usecase.dart';

part 'venue_state.dart';

class VenueCubit extends Cubit<VenueState> {
  VenueCubit({
    required this.addVenueUsecase,
    required this.deleteVenueUsecase,
    required this.updateVenueUsecase,
    required this.getVenueForClientUsecase,
    required this.getVenueForOwnerUsecase,
  }) : super(VenueInitial());
  final AddVenueUsecase addVenueUsecase;

  final DeleteVenueUsecase deleteVenueUsecase;
  final UpdateVenueUsecase updateVenueUsecase;
  final GetVenueForClientUsecase getVenueForClientUsecase;
  final GetVenueForOwnerUsecase getVenueForOwnerUsecase;

  Future<void> GetVenueForClient() async {
    try {
      emit(VenueLoading());
      final streamResponse = await getVenueForClientUsecase.call();
      streamResponse.listen((venues) {
        emit(VenueSuccessForClient(VenueEntities: venues));
      });
    } catch (e) {
      emit(VenueFailure());
    }
  }

  Future<void> GetVenueForOwner(String ownerid) async {
    try {
      emit(VenueLoading());
      final streamResponse = await getVenueForOwnerUsecase.call(ownerid);
      streamResponse.listen((Venue) {
        emit(VenueSuccessForOwner(VenueEntities: Venue));
      });
    } catch (e) {
      emit(VenueFailure());
    }
  }

  Future<void> AddVenue(
    VenueEntity VenueEntity,
  ) async {
    try {
      emit(VenueLoading());
      await addVenueUsecase.call(VenueEntity);
      await GetVenueForOwner(VenueEntity.owner_id!);
    } catch (e) {
      emit(VenueFailure());
    }
  }

  Future<void> DeleteVenue(
      {required String owner_id, required String hallid}) async {
    try {
      emit(VenueLoading());
      await deleteVenueUsecase.call(hallid);
      await GetVenueForOwner(owner_id);
    } catch (e) {
      emit(VenueFailure());
    }
  }

  Future<void> UpdateVenue(
    VenueEntity VenueEntity,
  ) async {
    try {
      emit(VenueLoading());
      await updateVenueUsecase.call(VenueEntity);
      emit(VenueSuccess());
    } catch (e) {
      emit(VenueFailure());
    }
  }
}
