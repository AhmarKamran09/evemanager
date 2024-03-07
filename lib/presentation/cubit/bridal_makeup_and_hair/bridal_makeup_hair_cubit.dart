import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bridal_makeup_hair_state.dart';

class BridalMakeupHairCubit extends Cubit<BridalMakeupHairState> {
  BridalMakeupHairCubit() : super(BridalMakeupHairInitial());
}
