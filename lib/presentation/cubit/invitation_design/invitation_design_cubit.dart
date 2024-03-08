import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/usecases/invitation_design/add_invitation_design_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/delete_invitation_design_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/get_invitation_design_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/get_invitation_design_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/update_invitation_design_usecase.dart';

part 'invitation_design_state.dart';

class InvitationDesignCubit extends Cubit<InvitationDesignState> {
  InvitationDesignCubit(
      {required this.addInvitationDesignUsecase,
      required this.deleteInvitationDesignUsecase,
      required this.updateInvitationDesignUsecase,
      required this.getInvitationDesignForClientUsecase,
      required this.getInvitationDesignForOwnerUsecase})
      : super(InvitationDesignInitial());

  final AddInvitationDesignUsecase addInvitationDesignUsecase;
  final DeleteInvitationDesignUsecase deleteInvitationDesignUsecase;
  final UpdateInvitationDesignUsecase updateInvitationDesignUsecase;
  final GetInvitationDesignForClientUsecase getInvitationDesignForClientUsecase;
  final GetInvitationDesignForOwnerUsecase getInvitationDesignForOwnerUsecase;

  Future<void> getInvitationDesignForClient() async {
    try {
      emit(InvitationDesignLoading());
      final streamResponse =
          await getInvitationDesignForClientUsecase.call();
      streamResponse.listen((invitation_design_entity) {
        emit(InvitationDesignSuccessForClient(
            invitation_design_entity: invitation_design_entity));
      });
    } catch (e) {
      emit(InvitationDesignFailure());
    }
  }

  Future<void> getInvitationDesignForOwner(String ownerid) async {
    try {
      emit(InvitationDesignLoading());
      final streamResponse =
          await getInvitationDesignForOwnerUsecase.call(ownerid);
      streamResponse.listen((invitation_design_entity) {
        emit(InvitationDesignSuccessForOwner(
            invitation_design_entity: invitation_design_entity));
      });
    } catch (e) {
      emit(InvitationDesignFailure());
    }
  }

  Future<void> addInvitationDesign(
    InvitationDesignEntity invitation_design_entity,
  ) async {
    try {
      emit(InvitationDesignLoading());
      await addInvitationDesignUsecase.call(invitation_design_entity);
      await getInvitationDesignForOwner(
          invitation_design_entity.owner_id!);
    } catch (e) {
      emit(InvitationDesignFailure());
    }
  }

  Future<void> deleteInvitationDesign(
      {required String owner_id, required String hallid}) async {
    try {
      emit(InvitationDesignLoading());
      await deleteInvitationDesignUsecase.call(hallid);
      await getInvitationDesignForOwner(owner_id);
    } catch (e) {
      emit(InvitationDesignFailure());
    }
  }

  Future<void> updateInvitationDesign(
    InvitationDesignEntity invitation_design_entity,
  ) async {
    try {
      emit(InvitationDesignLoading());
      await updateInvitationDesignUsecase.call(invitation_design_entity);
      emit(InvitationDesignSuccess());
    } catch (e) {
      emit(InvitationDesignFailure());
    }
  }

}