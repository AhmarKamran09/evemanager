import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'videography_state.dart';

class VideographyCubit extends Cubit<VideographyState> {
  VideographyCubit() : super(VideographyInitial());
}
