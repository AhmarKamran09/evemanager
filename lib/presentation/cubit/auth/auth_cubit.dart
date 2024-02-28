import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/usecases/User/get_current_uid_usecase.dart';
import 'package:evemanager/domain/usecases/User/is_sign_in_usecase.dart';
import 'package:evemanager/domain/usecases/User/sign_out_usecase.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUsecase getCurrentUidUsecase;
  final IsSignInUsecase isSignInUsecase;
  final SignOutUsecase signOutUsecase;
  AuthCubit({
    required this.getCurrentUidUsecase,
    required this.isSignInUsecase,
    required this.signOutUsecase,
  }) : super(AuthInitial());
  Future<void> AppStarted(BuildContext context) async {
    bool is_signed = await isSignInUsecase.call();
    String? uid = await getCurrentUidUsecase.call();
    try {
      if (is_signed) {
        // print(uid);
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> LoggedInWithAuthentication() async {
    String? uid = await getCurrentUidUsecase.call();
    try {
      if (uid != null) {
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> SignOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
