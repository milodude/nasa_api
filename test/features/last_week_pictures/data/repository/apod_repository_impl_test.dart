import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';
import 'package:nasa_api/features/last_week_pictures/data/repository/apod_repository_impl.dart';

import '../../../../fixtures/error_message_fixture.dart';
import '../../../../fixtures/pictures_of_the_day_fixtures.dart';
import '../../domain/use_case/get_last_week_pictures_use_case_test.mocks.dart';
import 'apod_repository_impl_test.mocks.dart';

@GenerateMocks([ApodDataSource])
void main() {
  final MockApodDataSource mockApodDataSource = MockApodDataSource();
  final ApodRepositoryImpl repositoryImpl =
      ApodRepositoryImpl(apodDataSource: mockApodDataSource);

  group('Pictures of the day repository implementation tests: ', () {
    test(
        'When requesting a list of pictures of the day should retrieve it without any issues',
        () async {
      //ARRANGE
      when(mockApodDataSource.getLastWeekPicturesOfTheDay())
          .thenAnswer((realInvocation) => Future.value(mockPicturesModelList));
      //ACT
      var result = await repositoryImpl.getLastWeekPictures();
      //ASSERT
      expect(true, result.isRight());
    });

    test('When requesting a list of pictures of the day should throw an error',
        () async {
      //ARRANGE
      when(mockApodDataSource.getLastWeekPicturesOfTheDay()).thenThrow(
          (realInvocation) => const ServerFailure(errorMessage: errorMessage));
      //ACT
      var result = await repositoryImpl.getLastWeekPictures();
      //ASSERT
      expect(true, result.isLeft());
    });
  });
}
