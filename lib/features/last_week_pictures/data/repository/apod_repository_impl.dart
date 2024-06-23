import 'package:dartz/dartz.dart';

import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/core/providers/connectivity_provider.dart';
import 'package:nasa_api/core/providers/debug_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';

import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';
import 'package:nasa_api/features/local_data/data/data_source/local_pictures_of_the_day_data_source.dart';

import '../../domain/repository/apod_repository.dart';

/// ApodRepositoryImpl
///
/// Implementation of the repository for pictures of the day
class ApodRepositoryImpl extends ApodRepository {
  final ApodDataSource apodDataSource;
  final ConnectivityProvider connectivityProvider;
  final LocalPicturesOfTheDayDataSource localPicturesOfTheDayDataSource;

  ApodRepositoryImpl({
    required this.apodDataSource,
    required this.connectivityProvider,
    required this.localPicturesOfTheDayDataSource,
  });

  @override
  Future<Either<Failure, List<PictureOfTheDay>>> getLastWeekPictures(
      bool hasConnection) async {
    try {
      if (!hasConnection) {
        //tengo que llamar al local
        final List<PicturesOfTheDayModel> localData =
            await localPicturesOfTheDayDataSource.getPictures();
        if (localData.isEmpty) {
          return const Left(NoConnectionFailure(
              errorMessage: 'No internet and no local data'));
        } else {
          DebugProvider.debugLog('$runtimeType] - Returning local data');
          return Right(localData);
        }
      }
      final List<PicturesOfTheDayModel> picturesList =
          await apodDataSource.getLastWeekPicturesOfTheDay();
      DebugProvider.debugLog(
          '[$runtimeType] - Adding network data to local data');
      await localPicturesOfTheDayDataSource.clearPictures();
      await localPicturesOfTheDayDataSource.addPictures(picturesList);
      return Right(picturesList);
    } catch (error) {
      DebugProvider.debugLog(error.toString());
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }
}
