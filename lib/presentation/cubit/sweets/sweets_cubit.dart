import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/usecases/sweets/add_sweets_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/delete_sweets_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/get_sweets_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/get_sweets_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/update_sweets_usecase.dart';

part 'sweets_state.dart';

class SweetsCubit extends Cubit<SweetsState> {
  SweetsCubit(
      {required this.addSweetsUsecase,
      required this.deleteSweetsUsecase,
      required this.updateSweetsUsecase,
      required this.getSweetsForClientUsecase,
      required this.getSweetsForOwnerUsecase})
      : super(SweetsInitial());

  final AddSweetsUsecase addSweetsUsecase;
  final DeleteSweetsUsecase deleteSweetsUsecase;
  final UpdateSweetsUsecase updateSweetsUsecase;
  final GetSweetsForClientUsecase getSweetsForClientUsecase;
  final GetSweetsForOwnerUsecase getSweetsForOwnerUsecase;

  Future<void> getSweetsForClient() async {
    try {
      emit(SweetsLoading());
      final streamResponse = await getSweetsForClientUsecase.call();
      streamResponse.listen((sweets_entity) {
        emit(SweetsSuccessForClient(sweets_entity: sweets_entity));
      });
    } catch (e) {
      emit(SweetsFailure());
    }
  }

  Future<void> getSweetsForOwner(String ownerid) async {
    try {
      emit(SweetsLoading());
      final streamResponse = await getSweetsForOwnerUsecase.call(ownerid);
      streamResponse.listen((sweets_entity) {
        emit(SweetsSuccessForOwner(sweets_entity: sweets_entity));
      });
    } catch (e) {
      emit(SweetsFailure());
    }
  }

  Future<void> addSweets(
    SweetEntity sweets_entity,
  ) async {
    try {
      emit(SweetsLoading());
      await addSweetsUsecase.call(sweets_entity);
      await getSweetsForOwner(sweets_entity.owner_id!);
    } catch (e) {
      emit(SweetsFailure());
    }
  }

  Future<void> deleteSweets(
      {required String owner_id, required String hallid}) async {
    try {
      emit(SweetsLoading());
      await deleteSweetsUsecase.call(hallid);
      await getSweetsForOwner(owner_id);
    } catch (e) {
      emit(SweetsFailure());
    }
  }

  Future<void> updateSweets(
    SweetEntity sweets_entity,
  ) async {
    try {
      emit(SweetsLoading());
      await updateSweetsUsecase.call(sweets_entity);
      emit(SweetsSuccess());
    } catch (e) {
      emit(SweetsFailure());
    }
  }
}