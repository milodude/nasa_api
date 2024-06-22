import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/core/use_case/base_use_case.dart';
import 'package:nasa_api/features/last_week_pictures/domain/use_case/get_last_week_pictures_use_case.dart';

import '../../domain/entity/picture_of_the_day.dart';

part 'apod_event.dart';
part 'apod_state.dart';

/// ApodBloc
///
/// Pictures of the day bloc
class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final GetLastWeekPicturesUseCase getLastWeekPicturesUseCase;
  ApodBloc({required this.getLastWeekPicturesUseCase}) : super(ApodInitial()) {
    on<GetLastWeekPicsEvent>(
        ((event, emit) => _getLastWeekPictures(event, emit)));
  }

  Future<void> _getLastWeekPictures(
    GetLastWeekPicsEvent event,
    Emitter<ApodState> emit,
  ) async {
    emit(ApodLoading());
    final Either<Failure, List<PictureOfTheDay>> result =
        await getLastWeekPicturesUseCase.call(NoParams());

    result.fold((Failure error) {
      emit(ApodError(errorMessage: error.errorMessage));
    }, (List<PictureOfTheDay> picturesList) {
      emit(ApodLoaded(picturesList: picturesList));
    });
  }
}
