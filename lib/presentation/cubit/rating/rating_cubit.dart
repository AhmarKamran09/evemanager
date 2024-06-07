import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/usecases/rating/add_rating_usecase.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit({
    required this.addRatingUsecase,
  }) : super(RatingInitial());
  final AddRatingUsecase addRatingUsecase;

  Future<void> addRating(
      {required double rating,
      required String serviceId,
      required Firebase_enum firebase_enum}) async {
    try {
      emit(RatingLoading());
      await addRatingUsecase.call(
          rating: rating, serviceId: serviceId, firebase_enum: firebase_enum);
      emit(RatingSuccess());
    } catch (e) {
      emit(RatingFailure());
    }
  }
}
