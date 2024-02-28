import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/domain/usecases/marriage_halls/add_marriage_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/delete_marriage_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/edit_availability_of_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/get_marriage_hall_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/get_marriage_hall_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/update_marriage_hall_pictures_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/update_marriage_hall_usecase.dart';

part 'marriage_hall_state.dart';

class MarriageHallCubit extends Cubit<MarriageHallState> {
  MarriageHallCubit({
    required this.addMarriageHallUsecase,
    required this.editAvailabilityOfHallUsecase,
    required this.deleteMarriageHallUsecase,
    required this.updateMarriageHallPicturesUsecase,
    required this.updateMarriageHallUsecase,
    required this.getMarriageHallForClientUsecase,
    required this.getMarriageHallForOwnerUsecase,
  }) : super(MarriageHallInitial());
  final AddMarriageHallUsecase addMarriageHallUsecase;
  final EditAvailabilityOfHallUsecase editAvailabilityOfHallUsecase;
  final DeleteMarriageHallUsecase deleteMarriageHallUsecase;
  final UpdateMarriageHallPicturesUsecase updateMarriageHallPicturesUsecase;
  final UpdateMarriageHallUsecase updateMarriageHallUsecase;
  final GetMarriageHallForClientUsecase getMarriageHallForClientUsecase;
  final GetMarriageHallForOwnerUsecase getMarriageHallForOwnerUsecase;

  Future<void> GetMarriageHallForClient() async {
    try {
      emit(MarriageHallLoading());
      final streamResponse = await getMarriageHallForClientUsecase.call();
      streamResponse.listen((marriagehalls) {
        emit(MarriageHallSuccessForClient(marriageHallEntities: marriagehalls));
        // emit(MarriageHallSuccess(marriageHallEntities: marriagehalls));
      });
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> GetMarriageHallForOwner(String ownerid) async {
    try {
      emit(MarriageHallLoading());
      final streamResponse = await getMarriageHallForOwnerUsecase.call(ownerid);
      streamResponse.listen((marriagehalls) {
        emit(MarriageHallSuccessForOwner(marriageHallEntities: marriagehalls));
        // emit(MarriageHallSuccess(marriageHallEntities: marriagehalls));
      });
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> AddMarriageHall(
    MarriageHallEntity marriageHallEntity,
  ) async {
    try {
      emit(MarriageHallLoading());
      await addMarriageHallUsecase.call(marriageHallEntity);
      // emit(MarriageHallSuccess());
      await GetMarriageHallForOwner(marriageHallEntity.owner_id!);
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> DeleteMarriageHall(
      {required String owner_id, required String hallid}) async {
    try {
      emit(MarriageHallLoading());
      await deleteMarriageHallUsecase.call(hallid);
      // emit(MarriageHallSuccess());
      await GetMarriageHallForOwner(owner_id);
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> EditAvailabilityOfHall(
      String id, Map<String, bool> availability) async {
    try {
      emit(MarriageHallLoading());
      await editAvailabilityOfHallUsecase.call(id, availability);
      emit(MarriageHallSuccess());
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> UpdateMarriageHallPictures(String id, List<File>? images) async {
    try {
      emit(MarriageHallLoading());
      await updateMarriageHallPicturesUsecase.call(id, images);
      emit(MarriageHallSuccess());
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }

  Future<void> UpdateMarriageHall(
    MarriageHallEntity marriageHallEntity,
  ) async {
    try {
      emit(MarriageHallLoading());

      await updateMarriageHallUsecase.call(marriageHallEntity);
      emit(MarriageHallSuccess());
    } catch (e) {
      emit(MarriageHallFailure());
    }
  }
}
