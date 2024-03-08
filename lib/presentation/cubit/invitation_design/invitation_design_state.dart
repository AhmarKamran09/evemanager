part of 'invitation_design_cubit.dart';

sealed class InvitationDesignState extends Equatable {
  const InvitationDesignState();

  @override
  List<Object> get props => [];
}

final class InvitationDesignInitial extends InvitationDesignState {}
final class InvitationDesignSuccess extends InvitationDesignState {
  final List<InvitationDesignEntity>? invitation_design_entity;

  InvitationDesignSuccess({this.invitation_design_entity});

  @override
  List<Object> get props => [];
}

final class InvitationDesignSuccessForClient extends InvitationDesignState {
  final List<InvitationDesignEntity>? invitation_design_entity;

  InvitationDesignSuccessForClient({required this.invitation_design_entity});

  @override
  List<Object> get props => [];
}

final class InvitationDesignSuccessForOwner extends InvitationDesignState {
  final List<InvitationDesignEntity>? invitation_design_entity;

  InvitationDesignSuccessForOwner({required this.invitation_design_entity});

  @override
  List<Object> get props => [];
}

final class InvitationDesignFailure extends InvitationDesignState {
  @override
  List<Object> get props => [];
}

final class InvitationDesignLoading extends InvitationDesignState {
  @override
  List<Object> get props => [];
}
