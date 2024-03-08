import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/usecases/transportation/add_transportation_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/delete_transportation_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/get_transportation_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/get_transportation_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/update_transportation_usecase.dart';

part 'transportation_state.dart';
class TransportationCubit extends Cubit<TransportationState> {
  TransportationCubit(
      {required this.addTransportationUsecase,
      required this.deleteTransportationUsecase,
      required this.updateTransportationUsecase,
      required this.getTransportationForClientUsecase,
      required this.getTransportationForOwnerUsecase})
      : super(TransportationInitial());

  final AddTransportationUsecase addTransportationUsecase;
  final DeleteTransportationUsecase deleteTransportationUsecase;
  final UpdateTransportationUsecase updateTransportationUsecase;
  final GetTransportationForClientUsecase getTransportationForClientUsecase;
  final GetTransportationForOwnerUsecase getTransportationForOwnerUsecase;

  Future<void> getTransportationForClient() async {
    try {
      emit(TransportationLoading());
      final streamResponse =
          await getTransportationForClientUsecase.call();
      streamResponse.listen((transportation_entity) {
        emit(TransportationSuccessForClient(
            transportation_entity: transportation_entity));
      });
    } catch (e) {
      emit(TransportationFailure());
    }
  }

  Future<void> getTransportationForOwner(String ownerid) async {
    try {
      emit(TransportationLoading());
      final streamResponse =
          await getTransportationForOwnerUsecase.call(ownerid);
      streamResponse.listen((transportation_entity) {
        emit(TransportationSuccessForOwner(
            transportation_entity: transportation_entity));
      });
    } catch (e) {
      emit(TransportationFailure());
    }
  }

  Future<void> addTransportation(
    TransportationEntity transportation_entity,
  ) async {
    try {
      emit(TransportationLoading());
      await addTransportationUsecase.call(transportation_entity);
      await getTransportationForOwner(
          transportation_entity.owner_id!);
    } catch (e) {
      emit(TransportationFailure());
    }
  }

  Future<void> deleteTransportation(
      {required String owner_id, required String hallid}) async {
    try {
      emit(TransportationLoading());
      await deleteTransportationUsecase.call(hallid);
      await getTransportationForOwner(owner_id);
    } catch (e) {
      emit(TransportationFailure());
    }
  }

  Future<void> updateTransportation(
    TransportationEntity transportation_entity,
  ) async {
    try {
      emit(TransportationLoading());
      await updateTransportationUsecase.call(transportation_entity);
      emit(TransportationSuccess());
    } catch (e) {
      emit(TransportationFailure());
    }
  }
}