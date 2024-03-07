import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photography_state.dart';

class PhotographyCubit extends Cubit<PhotographyState> {
  PhotographyCubit() : super(PhotographyInitial());
}
