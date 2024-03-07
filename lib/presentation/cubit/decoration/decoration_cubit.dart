import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'decoration_state.dart';

class DecorationCubit extends Cubit<DecorationState> {
  DecorationCubit() : super(DecorationInitial());
}
