import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/usecases/decorations/add_decorations_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/delete_decorations_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/get_decorations_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/get_decorations_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/update_decorations_usecase.dart';

part 'decoration_state.dart';

class DecorationCubit extends Cubit<DecorationState> {
  
DecorationCubit(
      {required this.addDecorationsUsecase,
      required this.deleteDecorationsUsecase,
      required this.updateDecorationsUsecase,
      required this.getDecorationsForClientUsecase,
      required this.getDecorationsForOwnerUsecase})
      : super(DecorationInitial());

  final AddDecorationsUsecase addDecorationsUsecase;
  final DeleteDecorationsUsecase deleteDecorationsUsecase;
  final UpdateDecorationsUsecase updateDecorationsUsecase;
  final GetDecorationsForClientUsecase getDecorationsForClientUsecase;
  final GetDecorationsForOwnerUsecase getDecorationsForOwnerUsecase;

  Future<void> GetDecorationsForClient() async {
    try {
      emit(DecorationsLoading());
      final streamResponse = await getDecorationsForClientUsecase.call();
      streamResponse.listen((decorations_entity) {
        emit(DecorationsSuccessForClient(decorations_entity: decorations_entity));
      });
    } catch (e) {
      emit(DecorationsFailure());
    }
  }

  Future<void> GetDecorationsForOwner(String ownerid) async {
    try {
      emit(DecorationsLoading());
      final streamResponse = await getDecorationsForOwnerUsecase.call(ownerid);
      streamResponse.listen((decorations_entity) {
        emit(DecorationsSuccessForOwner(decorations_entity: decorations_entity));
      });
    } catch (e) {
      emit(DecorationsFailure());
    }
  }

  Future<void> AddDecorations(
    DecorationsEntity decorations_entity,
  ) async {
    try {
      emit(DecorationsLoading());
      await addDecorationsUsecase.call(decorations_entity);
      await GetDecorationsForOwner(decorations_entity.owner_id!);
    } catch (e) {
      emit(DecorationsFailure());
    }
  }

  Future<void> DeleteDecorations(
      {required String owner_id, required String hallid}) async {
    try {
      emit(DecorationsLoading());
      await deleteDecorationsUsecase.call(hallid);
      await GetDecorationsForOwner(owner_id);
    } catch (e) {
      emit(DecorationsFailure());
    }
  }

  Future<void> UpdateDecorations(
    DecorationsEntity decorations_entity,
  ) async {
    try {
      emit(DecorationsLoading());

      await updateDecorationsUsecase.call(decorations_entity);
      emit(DecorationsSuccess());
    } catch (e) {
      emit(DecorationsFailure());
    }
  }


}
