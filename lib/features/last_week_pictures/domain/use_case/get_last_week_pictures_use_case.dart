import 'package:dartz/dartz.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';
import 'package:nasa_api/features/last_week_pictures/domain/repository/apod_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/base_use_case.dart';

/// GetLastWeekPicturesUseCase
///
/// Use case to get last week pictures of the day.
class GetLastWeekPicturesUseCase
    extends UseCase<List<PictureOfTheDay>, NoParams> {
  final ApodRepository apodRepository;

  GetLastWeekPicturesUseCase({required this.apodRepository});
  @override
  Future<Either<Failure, List<PictureOfTheDay>>> call(NoParams params) {
    return apodRepository.getLastWeekPictures();
  }
}
