import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/usecases/User/delete_user_usecase.dart';
import 'package:evemanager/domain/usecases/User/get_current_uid_usecase.dart';
import 'package:evemanager/domain/usecases/User/get_user_usecase.dart';
import 'package:evemanager/domain/usecases/User/update_user-usecase.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserUsecase getUserUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final GetCurrentUidUsecase uidusecase;
  UserProfileCubit({
    required this.uidusecase,
    required this.getUserUsecase,
    required this.deleteUserUsecase,
    required this.updateUserUsecase,
  }) : super(UserProfileInitial());

  Future<void> GetUser() async {
    try {
      emit(UserProfileLoading());
      String? uid = await uidusecase.call();
      UserEntity user = await getUserUsecase.call(uid: uid!);
      // print(uid);
      // if (uid != null) {
      // print(uid);
      emit(UserProfileSuccess(user: user));
      // print("success");
      // } else {
      // emit(UserProfileFailure());
      // }
    } on SocketException catch (_) {
      emit(UserProfileFailure());
    } catch (e) {
      print("Error in GetUser: $e");
      emit(UserProfileFailure());
    }
  }

  Future<void> DeleteUser({required UserEntity user}) async {
    emit(UserProfileLoading());
    try {
      await deleteUserUsecase.call(uid: user.uid!);
      emit(UserProfileFailure());
      DisplayToast("Account Deleted");
    } on SocketException catch (_) {
      emit(UserProfileSuccess(user: user));
    }
  }

  // void UserProfileToHome() {
  //   emit(UserProfileToMain());
  // }

  Future<void> UpdateUser({required UserEntity user}) async {
    try {
      emit(UserProfileLoading());
      await updateUserUsecase.call(user);
      await GetUser();
      emit(UserProfileSuccess(user: user));
    } on SocketException catch (_) {
      DisplayToast("Unable to Update!! Failure");
      emit(UserProfileSuccess(user: user));
    }
  }
}
