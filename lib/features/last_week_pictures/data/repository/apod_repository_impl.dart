import 'package:dartz/dartz.dart';

import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/core/providers/connectivity_provider.dart';
import 'package:nasa_api/core/providers/debug_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';

import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

import '../../domain/repository/apod_repository.dart';

/// ApodRepositoryImpl
///
/// Implementation of the repository for pictures of the day
class ApodRepositoryImpl extends ApodRepository {
  final ApodDataSource apodDataSource;
  final ConnectivityProvider connectivityProvider;

  ApodRepositoryImpl({
    required this.apodDataSource,
    required this.connectivityProvider,
  });

  @override
  Future<Either<Failure, List<PictureOfTheDay>>> getLastWeekPictures(
      bool hasConnection) async {
    try {
      await connectivityProvider.checkInitialConnection();
      if (!hasConnection) {
        return const Left(NoConnectionFailure(errorMessage: 'No internet'));
      }
      final List<PictureOfTheDay> picturesList =
          await apodDataSource.getLastWeekPicturesOfTheDay();
      return Right(picturesList);
    } catch (error) {
      DebugProvider.debugLog(error.toString());
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }
}
