import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/usecases/clothing/add_clothing_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/delete_clothing_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/get_clothing_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/get_clothing_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/update_clothing_usecase.dart';

part 'clothing_state.dart';

class ClothingCubit extends Cubit<ClothingState> {
  ClothingCubit(
      {required this.addClothingUsecase,
      required this.deleteClothingUsecase,
      required this.updateClothingUsecase,
      required this.getClothingForClientUsecase,
      required this.getClothingForOwnerUsecase})
      : super(ClothingInitial());

  final AddClothingUsecase addClothingUsecase;
  final DeleteClothingUsecase deleteClothingUsecase;
  final UpdateClothingUsecase updateClothingUsecase;
  final GetClothingForClientUsecase getClothingForClientUsecase;
  final GetClothingForOwnerUsecase getClothingForOwnerUsecase;

  Future<void> GetClothingForClient() async {
    try {
      emit(ClothingLoading());
      final streamResponse = await getClothingForClientUsecase.call();
      streamResponse.listen((clothing_entity) {
        emit(ClothingSuccessForClient(clothing_entity: clothing_entity));
      });
    } catch (e) {
      emit(ClothingFailure());
    }
  }

  Future<void> GetClothingForOwner(String ownerid) async {
    try {
      emit(ClothingLoading());
      final streamResponse = await getClothingForOwnerUsecase.call(ownerid);
      streamResponse.listen((clothing_entity) {
        emit(ClothingSuccessForOwner(clothing_entity: clothing_entity));
      });
    } catch (e) {
      emit(ClothingFailure());
    }
  }

  Future<void> AddClothing(
    ClothingEntity clothing_entity,
  ) async {
    try {
      emit(ClothingLoading());
      await addClothingUsecase.call(clothing_entity);
      await GetClothingForOwner(clothing_entity.owner_id!);
    } catch (e) {
      emit(ClothingFailure());
    }
  }

  Future<void> DeleteClothing(
      {required String owner_id, required String hallid}) async {
    try {
      emit(ClothingLoading());
      await deleteClothingUsecase.call(hallid);
      await GetClothingForOwner(owner_id);
    } catch (e) {
      emit(ClothingFailure());
    }
  }

  Future<void> UpdateClothing(
    ClothingEntity clothing_entity,
  ) async {
    try {
      emit(ClothingLoading());

      await updateClothingUsecase.call(clothing_entity);
      emit(ClothingSuccess());
    } catch (e) {
      emit(ClothingFailure());
    }
  }
}
