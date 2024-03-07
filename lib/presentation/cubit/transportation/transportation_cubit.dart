import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transportation_state.dart';

class TransportationCubit extends Cubit<TransportationState> {
  TransportationCubit() : super(TransportationInitial());
}
