import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/domain/usecases/videography/add_videography_usecase.dart';
import 'package:evemanager/domain/usecases/videography/delete_videography_usecase.dart';
import 'package:evemanager/domain/usecases/videography/get_videography_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/videography/get_videography_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/videography/update_videography_usecase.dart';

part 'videography_state.dart';

class VideographyCubit extends Cubit<VideographyState> {
  VideographyCubit(
      {required this.addVideographyUsecase,
      required this.deleteVideographyUsecase,
      required this.updateVideographyUsecase,
      required this.getVideographyForClientUsecase,
      required this.getVideographyForOwnerUsecase})
      : super(VideographyInitial());

  final AddVideographyUsecase addVideographyUsecase;
  final DeleteVideographyUsecase deleteVideographyUsecase;
  final UpdateVideographyUsecase updateVideographyUsecase;
  final GetVideographyForClientUsecase getVideographyForClientUsecase;
  final GetVideographyForOwnerUsecase getVideographyForOwnerUsecase;

  Future<void> getVideographyForClient() async {
    try {
      emit(VideographyLoading());
      final streamResponse =
          await getVideographyForClientUsecase.call();
      streamResponse.listen((videography_entity) {
        emit(VideographySuccessForClient(
            videography_entity: videography_entity));
      });
    } catch (e) {
      emit(VideographyFailure());
    }
  }

  Future<void> getVideographyForOwner(String ownerid) async {
    try {
      emit(VideographyLoading());
      final streamResponse =
          await getVideographyForOwnerUsecase.call(ownerid);
      streamResponse.listen((videography_entity) {
        emit(VideographySuccessForOwner(
            videography_entity: videography_entity));
      });
    } catch (e) {
      emit(VideographyFailure());
    }
  }

  Future<void> addVideography(
    VideographyEntity videography_entity,
  ) async {
    try {
      emit(VideographyLoading());
      await addVideographyUsecase.call(videography_entity);
      await getVideographyForOwner(
          videography_entity.owner_id!);
    } catch (e) {
      emit(VideographyFailure());
    }
  }

  Future<void> deleteVideography(
      {required String owner_id, required String hallid}) async {
    try {
      emit(VideographyLoading());
      await deleteVideographyUsecase.call(hallid);
      await getVideographyForOwner(owner_id);
    } catch (e) {
      emit(VideographyFailure());
    }
  }

  Future<void> updateVideography(
    VideographyEntity videography_entity,
  ) async {
    try {
      emit(VideographyLoading());
      await updateVideographyUsecase.call(videography_entity);
      emit(VideographySuccess());
    } catch (e) {
      emit(VideographyFailure());
    }
  }
}