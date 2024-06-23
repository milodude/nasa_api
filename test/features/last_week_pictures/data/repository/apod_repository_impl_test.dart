import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/core/providers/connectivity_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';
import 'package:nasa_api/features/last_week_pictures/data/repository/apod_repository_impl.dart';
import 'package:nasa_api/features/local_data/data/data_source/local_pictures_of_the_day_data_source.dart';

import '../../../../fixtures/error_message_fixture.dart';
import '../../../../fixtures/pictures_of_the_day/pictures_of_the_day_fixtures.dart';
import 'apod_repository_impl_test.mocks.dart';

@GenerateMocks(
    [ApodDataSource, ConnectivityProvider, LocalPicturesOfTheDayDataSource])
void main() {
  final MockApodDataSource mockApodDataSource = MockApodDataSource();
  final MockConnectivityProvider mockConnectivityProvider =
      MockConnectivityProvider();
  final MockLocalPicturesOfTheDayDataSource
      mockLocalPicturesOfTheDayDataSource =
      MockLocalPicturesOfTheDayDataSource();
  late ApodRepositoryImpl repositoryImpl = ApodRepositoryImpl(
    apodDataSource: mockApodDataSource,
    connectivityProvider: mockConnectivityProvider,
    localPicturesOfTheDayDataSource: mockLocalPicturesOfTheDayDataSource,
  );
  const bool connected = true;

  group('Pictures of the day repository implementation tests: ', () {
    test(
        'When requesting a list of pictures of the day should retrieve it without any issues',
        () async {
      //ARRANGE
      when(mockApodDataSource.getLastWeekPicturesOfTheDay())
          .thenAnswer((realInvocation) => Future.value(mockPicturesModelList));
      when(mockLocalPicturesOfTheDayDataSource.addPictures(any)).thenAnswer(
        (realInvocation) => Future<void>.value(),
      );
      when(mockLocalPicturesOfTheDayDataSource.clearPictures()).thenAnswer(
        (realInvocation) => Future<void>.value(),
      );
      //ACT
      var result = await repositoryImpl.getLastWeekPictures(connected);
      //ASSERT
      expect(true, result.isRight());
    });

    test('When requesting a list of pictures of the day should throw an error',
        () async {
      //ARRANGE
      when(mockApodDataSource.getLastWeekPicturesOfTheDay()).thenThrow(
          (realInvocation) => const ServerFailure(errorMessage: errorMessage));
      when(mockLocalPicturesOfTheDayDataSource.addPictures(any)).thenAnswer(
        (realInvocation) => Future.value(),
      );
      //ACT
      var result = await repositoryImpl.getLastWeekPictures(connected);
      //ASSERT
      expect(true, result.isLeft());
    });

    test(
        'When requesting a list of pictures and having no connection should retrieve it locally without any issues',
        () async {
      //ARRANGE
      const bool isNotConnected = false;
      when(mockLocalPicturesOfTheDayDataSource.getPictures())
          .thenAnswer((realInvocation) => Future.value(mockPicturesModelList));
      when(mockApodDataSource.getLastWeekPicturesOfTheDay())
          .thenAnswer((realInvocation) => Future.value(mockPicturesModelList));

      //ACT
      var result = await repositoryImpl.getLastWeekPictures(isNotConnected);
      //ASSERT
      verify(mockLocalPicturesOfTheDayDataSource.getPictures()).called(1);
      expect(true, result.isRight());
    });
  });
}
