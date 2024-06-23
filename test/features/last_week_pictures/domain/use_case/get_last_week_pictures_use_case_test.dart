import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';
import 'package:nasa_api/features/last_week_pictures/domain/repository/apod_repository.dart';
import 'package:nasa_api/features/last_week_pictures/domain/use_case/get_last_week_pictures_use_case.dart';

import '../../../../fixtures/error_message_fixture.dart';
import 'get_last_week_pictures_use_case_test.mocks.dart';

@GenerateMocks([ApodRepository])
void main() {
  final MockApodRepository mockApodRepository = MockApodRepository();
  final useCase = GetLastWeekPicturesUseCase(
    apodRepository: mockApodRepository,
  );

  final List<PictureOfTheDay> mockPicturesList = [
    PictureOfTheDay(
        date: DateTime.now(),
        copyright: 'copyright',
        explanation: 'some explanation',
        title: 'My title',
        url: 'someUrl'),
  ];
  const bool connected = true;

  group('${useCase.runtimeType}: tests', () {
    test('When requesting all the pictures of the week should retrieve a list',
        () async {
      //ASSERT
      when(mockApodRepository.getLastWeekPictures(connected)).thenAnswer(
          (realInvocation) => Future.value(Right(mockPicturesList)));
      //ACT
      var result = await useCase.call(connected);
      //ASSERT
      expect(result, Right(mockPicturesList));
      verify(mockApodRepository.getLastWeekPictures(connected)).called(1);
    });

    test('When requesting all the pictures of the week should throw an error',
        () async {
      //ASSERT
      when(mockApodRepository.getLastWeekPictures(connected)).thenAnswer(
          (realInvocation) => Future.value(
              const Left(ServerFailure(errorMessage: errorMessage))));
      //ACT
      var result = await useCase.call(connected);
      //ASSERT
      expect(result, const Left(ServerFailure(errorMessage: errorMessage)));
      verify(mockApodRepository.getLastWeekPictures(connected)).called(1);
    });
  });
}
