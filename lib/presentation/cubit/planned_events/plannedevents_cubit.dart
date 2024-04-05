import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plannedevents_state.dart';

class PlannedeventsCubit extends Cubit<PlannedeventsState> {
  PlannedeventsCubit() : super(PlannedeventsInitial());
}
