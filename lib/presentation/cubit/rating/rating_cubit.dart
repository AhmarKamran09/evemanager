import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/usecases/rating/add_rating_usecase.dart';
import 'package:evemanager/domain/usecases/rating/get_rating_usecase.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit({
    required this.addRatingUsecase,
    required this.getRatingUsecase,
  }) : super(RatingInitial());
  final AddRatingUsecase addRatingUsecase;
  final GetRatingUsecase getRatingUsecase;

  Future<void> addRating(RatingEntity ratingEntity) async {
    try {
      emit(RatingLoading());
      await addRatingUsecase.call(ratingEntity);
      emit(AddRatingSuccess());
    } catch (e) {
      emit(RatingFailure());
    }
  }

  Future<void> getRating({required serviceid}) async {
    try {
      emit(RatingLoading());
      double rating = await getRatingUsecase.call(serviceid);
      emit(RatingSuccess(ratingvalue: rating, serviceId: serviceid));
    } catch (e) {
      emit(RatingFailure());
    }
  }
}
