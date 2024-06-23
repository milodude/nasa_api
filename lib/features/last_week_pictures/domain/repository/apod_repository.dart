import 'package:dartz/dartz.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

abstract class ApodRepository {
  Future<Either<Failure, List<PictureOfTheDay>>> getLastWeekPictures(
      bool hasConnection);
}
