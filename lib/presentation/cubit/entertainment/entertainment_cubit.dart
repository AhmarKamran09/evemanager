import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'entertainment_state.dart';

class EntertainmentCubit extends Cubit<EntertainmentState> {
  EntertainmentCubit() : super(EntertainmentInitial());
}
