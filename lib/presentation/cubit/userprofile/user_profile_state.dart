part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}

final class UserProfileLoading extends UserProfileState {
  @override
  List<Object> get props => [];
}

final class UserProfileSuccess extends UserProfileState {
  final UserEntity user;

  UserProfileSuccess({required this.user});
  @override
  List<Object> get props => [
        user,
      ];
}

final class UserProfileFailure extends UserProfileState {
  @override
  List<Object> get props => [];
}
