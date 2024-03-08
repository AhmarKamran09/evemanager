import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/usecases/entertainment/add_entertainment_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/delete_entertainment_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/get_entertainment_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/get_entertainment_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/update_entertainment_usecase.dart';

part 'entertainment_state.dart';

class EntertainmentCubit extends Cubit<EntertainmentState> {
 EntertainmentCubit(
      {required this.addEntertainmentUsecase,
      required this.deleteEntertainmentUsecase,
      required this.updateEntertainmentUsecase,
      required this.getEntertainmentForClientUsecase,
      required this.getEntertainmentForOwnerUsecase})
      : super(EntertainmentInitial());

  final AddEntertainmentUsecase addEntertainmentUsecase;
  final DeleteEntertainmentUsecase deleteEntertainmentUsecase;
  final UpdateEntertainmentUsecase updateEntertainmentUsecase;
  final GetEntertainmentForClientUsecase getEntertainmentForClientUsecase;
  final GetEntertainmentForOwnerUsecase getEntertainmentForOwnerUsecase;

  Future<void> GetEntertainmentForClient() async {
    try {
      emit(EntertainmentLoading());
      final streamResponse = await getEntertainmentForClientUsecase.call();
      streamResponse.listen((entertainment_entity) {
        emit(EntertainmentSuccessForClient(entertainment_entity: entertainment_entity));
      });
    } catch (e) {
      emit(EntertainmentFailure());
    }
  }

  Future<void> GetEntertainmentForOwner(String ownerid) async {
    try {
      emit(EntertainmentLoading());
      final streamResponse = await getEntertainmentForOwnerUsecase.call(ownerid);
      streamResponse.listen((entertainment_entity) {
        emit(EntertainmentSuccessForOwner(entertainment_entity: entertainment_entity));
      });
    } catch (e) {
      emit(EntertainmentFailure());
    }
  }

  Future<void> AddEntertainment(
    EntertainmentEntity entertainment_entity,
  ) async {
    try {
      emit(EntertainmentLoading());
      await addEntertainmentUsecase.call(entertainment_entity);
      await GetEntertainmentForOwner(entertainment_entity.owner_id!);
    } catch (e) {
      emit(EntertainmentFailure());
    }
  }

  Future<void> DeleteEntertainment(
      {required String owner_id, required String hallid}) async {
    try {
      emit(EntertainmentLoading());
      await deleteEntertainmentUsecase.call(hallid);
      await GetEntertainmentForOwner(owner_id);
    } catch (e) {
      emit(EntertainmentFailure());
    }
  }

  Future<void> UpdateEntertainment(
    EntertainmentEntity entertainment_entity,
  ) async {
    try {
      emit(EntertainmentLoading());

      await updateEntertainmentUsecase.call(entertainment_entity);
      emit(EntertainmentSuccess());
    } catch (e) {
      emit(EntertainmentFailure());
    }
  }

}
