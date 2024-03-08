import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/usecases/photography/add_photography_usecase.dart';
import 'package:evemanager/domain/usecases/photography/delete_photography_usecase.dart';
import 'package:evemanager/domain/usecases/photography/get_photography_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/photography/get_photography_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/photography/update_photography_usecase.dart';

part 'photography_state.dart';
class PhotographyCubit extends Cubit<PhotographyState> {
  PhotographyCubit(
      {required this.addPhotographyUsecase,
      required this.deletePhotographyUsecase,
      required this.updatePhotographyUsecase,
      required this.getPhotographyForClientUsecase,
      required this.getPhotographyForOwnerUsecase})
      : super(PhotographyInitial());

  final AddPhotographyUsecase addPhotographyUsecase;
  final DeletePhotographyUsecase deletePhotographyUsecase;
  final UpdatePhotographyUsecase updatePhotographyUsecase;
  final GetPhotographyForClientUsecase getPhotographyForClientUsecase;
  final GetPhotographyForOwnerUsecase getPhotographyForOwnerUsecase;

  Future<void> getPhotographyForClient() async {
    try {
      emit(PhotographyLoading());
      final streamResponse =
          await getPhotographyForClientUsecase.call();
      streamResponse.listen((photography_entity) {
        emit(PhotographySuccessForClient(
            photography_entity: photography_entity));
      });
    } catch (e) {
      emit(PhotographyFailure());
    }
  }

  Future<void> getPhotographyForOwner(String ownerid) async {
    try {
      emit(PhotographyLoading());
      final streamResponse =
          await getPhotographyForOwnerUsecase.call(ownerid);
      streamResponse.listen((photography_entity) {
        emit(PhotographySuccessForOwner(
            photography_entity: photography_entity));
      });
    } catch (e) {
      emit(PhotographyFailure());
    }
  }

  Future<void> addPhotography(
    PhotographyEntity photography_entity,
  ) async {
    try {
      emit(PhotographyLoading());
      await addPhotographyUsecase.call(photography_entity);
      await getPhotographyForOwner(
          photography_entity.owner_id!);
    } catch (e) {
      emit(PhotographyFailure());
    }
  }

  Future<void> deletePhotography(
      {required String owner_id, required String hallid}) async {
    try {
      emit(PhotographyLoading());
      await deletePhotographyUsecase.call(hallid);
      await getPhotographyForOwner(owner_id);
    } catch (e) {
      emit(PhotographyFailure());
    }
  }

  Future<void> updatePhotography(
    PhotographyEntity photography_entity,
  ) async {
    try {
      emit(PhotographyLoading());
      await updatePhotographyUsecase.call(photography_entity);
      emit(PhotographySuccess());
    } catch (e) {
      emit(PhotographyFailure());
    }
  }
}
