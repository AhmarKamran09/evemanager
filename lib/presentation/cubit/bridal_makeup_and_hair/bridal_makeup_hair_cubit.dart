import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/add_bridal_makeup_&_hair_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/delete_bridal_makeup_&_hair_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/get_bridal_makeup_&_hair_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/get_bridal_makeup_&_hair_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/update_bridal_makeup_&_hair_usecase.dart';

part 'bridal_makeup_hair_state.dart';

class BridalMakeupHairCubit extends Cubit<BridalMakeupHairState> {
  BridalMakeupHairCubit({
    required this.addBridalMakeupAndHairUsecase,
    required this.deleteBridalMakeupAndHairUsecase,
    required this.updateBridalMakeupAndHairUsecase,
    required this.getBridalMakeupAndHairForClientUsecase,
    required this.getBridalMakeupAndHairForOwnerUsecase,
  }) : super(BridalMakeupHairInitial());

  final AddBridalMakeupAndHairUsecase addBridalMakeupAndHairUsecase;
  final DeleteBridalMakeupAndHairUsecase deleteBridalMakeupAndHairUsecase;
  final UpdateBridalMakeupAndHairUsecase updateBridalMakeupAndHairUsecase;
  final GetBridalMakeupAndHairForClientUsecase
      getBridalMakeupAndHairForClientUsecase;
  final GetBridalMakeupAndHairForOwnerUsecase
      getBridalMakeupAndHairForOwnerUsecase;


      

   Future<void> GetBridalMakeupHairForClient() async {
    try {
      emit(BridalMakeupHairLoading());
      final streamResponse = await getBridalMakeupAndHairForClientUsecase.call();
      streamResponse.listen((bridal_makeup_entity) {
        emit(BridalMakeupHairSuccessForClient(bridal_makeup_entity: bridal_makeup_entity));
      });
    } catch (e) {
      emit(BridalMakeupHairFailure());
    }
  }

  Future<void> GetBridalMakeupHairForOwner(String ownerid) async {
    try {
      emit(BridalMakeupHairLoading());
      final streamResponse = await getBridalMakeupAndHairForOwnerUsecase.call(ownerid);
      streamResponse.listen((bridal_makeup_entity) {
        emit( BridalMakeupHairSuccessForOwner(bridal_makeup_entity: bridal_makeup_entity));
     });
    } catch (e) {
      emit(BridalMakeupHairFailure());
    }
  }

  Future<void> AddBridalMakeupHair(
    BridalMakeupAndHairEntity bridal_makeup_entity,
  ) async {
    try {
      emit(BridalMakeupHairLoading());
      await addBridalMakeupAndHairUsecase.call(bridal_makeup_entity);
      await GetBridalMakeupHairForOwner(bridal_makeup_entity.owner_id!);
    } catch (e) {
      emit(BridalMakeupHairFailure());
    }
  }

  Future<void> DeleteBridalMakeupHair(
      {required String owner_id, required String hallid}) async {
    try {
      emit(BridalMakeupHairLoading());
      await deleteBridalMakeupAndHairUsecase.call(hallid);
      await GetBridalMakeupHairForOwner(owner_id);
    } catch (e) {
      emit(BridalMakeupHairFailure());
    }
  }
 
  Future<void> UpdateBridalMakeupHair(
    BridalMakeupAndHairEntity bridal_makeup_entity,
  ) async {
    try {
      emit(BridalMakeupHairLoading());

      await updateBridalMakeupAndHairUsecase.call(bridal_makeup_entity);
      emit(BridalMakeupHairSuccess());
    } catch (e) {
      emit(BridalMakeupHairFailure());
    }
  }

}
