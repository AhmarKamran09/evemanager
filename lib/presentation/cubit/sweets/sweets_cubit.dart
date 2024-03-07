import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sweets_state.dart';

class SweetsCubit extends Cubit<SweetsState> {
  SweetsCubit() : super(SweetsInitial());
}
