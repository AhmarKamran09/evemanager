import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invitation_design_state.dart';

class InvitationDesignCubit extends Cubit<InvitationDesignState> {
  InvitationDesignCubit() : super(InvitationDesignInitial());
}
