import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());
}
