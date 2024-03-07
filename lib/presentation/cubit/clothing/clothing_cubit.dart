import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clothing_state.dart';

class ClothingCubit extends Cubit<ClothingState> {
  ClothingCubit() : super(ClothingInitial());
}
