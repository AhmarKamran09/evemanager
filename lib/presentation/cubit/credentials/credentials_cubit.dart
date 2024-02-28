import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/usecases/User/sign_in_usecase.dart';
import 'package:evemanager/domain/usecases/User/sign_up_usecase.dart';
part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  final SignInUsecase signInUsecase;
  final SignUpUserUsecase signUpUserUsecase;

  CredentialsCubit({
    required this.signInUsecase,
    required this.signUpUserUsecase,
  }) : super(CredentialsInitial());

  Future<void> SignInUser({required UserEntity user}) async {
    try {
      emit(CredentialsLoading());
      bool isignin = await signInUsecase.call(user);
      if (!isignin) {
        emit(CredentialFailure());
      } else {
        emit(CredentialsSuccess());
      }
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> SignUpUser({required UserEntity user}) async {
    try {
      emit(CredentialsLoading());
      await signUpUserUsecase.call(user);
      if (user.email == "" || user.password == "") {
        emit(CredentialFailure());
      } else {
        emit(CredentialsSuccess());
      }
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }
}
