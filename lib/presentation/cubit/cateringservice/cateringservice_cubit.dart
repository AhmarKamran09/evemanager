import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/usecases/catering/add_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/delete_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/catering/update_catering_service_usecase.dart';
part 'cateringservice_state.dart';


class CateringserviceCubit extends Cubit<CateringserviceState> {
  CateringserviceCubit({
    required this.addCateringServiceUsecase,
    required this.deleteCateringServiceUsecase,
    required this.getCateringServiceForClientUsecase,
    required this.getCateringServiceForOwnerUsecase,
    required this.updateCateringServiceUsecase,
  }) : super(CateringserviceInitial());
  final AddCateringServiceUsecase addCateringServiceUsecase;
  final DeleteCateringServiceUsecase deleteCateringServiceUsecase;
  final GetCateringServiceForClientUsecase getCateringServiceForClientUsecase;
  final GetCateringServiceForOwnerUsecase getCateringServiceForOwnerUsecase;
  final UpdateCateringServiceUsecase updateCateringServiceUsecase; 


   Future<void> GetCateringServicesForClient() async {
    try {
      emit(CateringserviceLoading());
      final streamResponse = await getCateringServiceForClientUsecase.call();
      streamResponse.listen((catering_services) {
        emit(CateringserviceSuccessForClient(catering_entities: catering_services));
      });
    } catch (e) {
      emit(CateringserviceFailure());
    }
  }

  Future<void> GetCateringServiceForOwner(String ownerid) async {
    try {
      emit(CateringserviceLoading());
      final streamResponse = await getCateringServiceForOwnerUsecase.call(ownerid);
      streamResponse.listen((cateringservices) {
        emit(CateringserviceSuccessForOwner(catering_entities: cateringservices));
     });
    } catch (e) {
      emit(CateringserviceFailure());
    }
  }

  Future<void> AddCateringService(
    CateringEntity cateringEntity,
  ) async {
    try {
      emit(CateringserviceLoading());
      await addCateringServiceUsecase.call(cateringEntity);
      await GetCateringServiceForOwner(cateringEntity.owner_id!);
    } catch (e) {
      emit(CateringserviceFailure());
    }
  }

  Future<void> DeleteCateringService(
      {required String owner_id, required String hallid}) async {
    try {
      emit(CateringserviceLoading());
      await deleteCateringServiceUsecase.call(hallid);
      await GetCateringServiceForOwner(owner_id);
    } catch (e) {
      emit(CateringserviceFailure());
    }
  }
 
  Future<void> UpdateCateringService(
    CateringEntity cateringEntity,
  ) async {
    try {
      emit(CateringserviceLoading());

      await updateCateringServiceUsecase.call(cateringEntity);
      emit(CateringserviceSuccess());
    } catch (e) {
      emit(CateringserviceFailure());
    }
  }

}
