part of 'credentials_cubit.dart';

sealed class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

final class CredentialsInitial extends CredentialsState {
  @override
  List<Object> get props => [];
}

final class CredentialsLoading extends CredentialsState {
  @override
  List<Object> get props => [];
}

final class CredentialsSuccess extends CredentialsState {
  @override
  List<Object> get props => [];
}

final class CredentialsSuccessForResetPassword extends CredentialsState {
  @override
  List<Object> get props => [];
}

final class CredentialFailure extends CredentialsState {
  @override
  List<Object> get props => [];
}
