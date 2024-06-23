import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/error/exceptions.dart';
import 'package:nasa_api/core/providers/sembast_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';
import 'package:nasa_api/features/local_data/data/data_source/local_pictures_of_the_day_data_source.dart';

import '../../../../fixtures/pictures_of_the_day/pictures_of_the_day_fixtures.dart';
import 'local_pictures_of_the_day_data_source_test.mocks.dart';

@GenerateMocks([SembastProvider])
void main() {
  final MockSembastProvider mockSembastProvider = MockSembastProvider();
  final LocalPicturesOfTheDayDataSource localDb =
      LocalPicturesOfTheDayDataSourceImpl(sembastProvider: mockSembastProvider);
  group('${localDb.runtimeType} tests:', () {
    test('Should get a list of pictures of the day', () async {
      //ARRANGE
      when(mockSembastProvider
              .getAll<PicturesOfTheDayModel>(PicturesOfTheDayModel.fromJson))
          .thenAnswer(
        (realInvocation) => Future.value(mockPicturesModelList),
      );
      //ACT
      var result = await localDb.getPictures();
      //ASSERT
      expect(result.length, 2);
    });

    test('When getting a list of pictures of the day should throw an error',
        () async {
      //ARRANGE
      when(mockSembastProvider
              .getAll<PicturesOfTheDayModel>(PicturesOfTheDayModel.fromJson))
          .thenThrow(
        ServerException(),
      );
      //ACT
      var result = localDb.getPictures();
      //ASSERT
      expect(() => result, throwsA(const TypeMatcher<ServerException>()));
    });

    test('Should add a list of pictures of the day', () async {
      //ARRANGE
      when(mockSembastProvider.insert<PicturesOfTheDayModel>(any)).thenAnswer(
        (realInvocation) => Future.value(1),
      );
      //ACT
      await localDb.addPictures(mockPicturesModelList);
      //ASSERT
      verify(mockSembastProvider.insert<PicturesOfTheDayModel>(any)).called(2);
    });

    test('When adding a list of pictures of the day should throw an error',
        () async {
      //ARRANGE
      when(mockSembastProvider.insert<PicturesOfTheDayModel>(any)).thenThrow(
        ServerException(),
      );
      //ACT
      var result = localDb.addPictures(mockPicturesModelList);
      //ASSERT
      expect(() => result, throwsA(const TypeMatcher<ServerException>()));
    });

    test('Should clear the db without any issues', () async {
      //ARRANGE
      when(mockSembastProvider.clear<PicturesOfTheDayModel>()).thenAnswer(
        (realInvocation) => Future.value(),
      );
      //ACT
      await localDb.clearPictures();
      //ASSERT
      verify(mockSembastProvider.clear<PicturesOfTheDayModel>()).called(1);
    });

    test('When clearing the db should throw an error', () async {
      //ARRANGE
      when(mockSembastProvider.clear<PicturesOfTheDayModel>()).thenThrow(
        ServerException(),
      );
      //ACT
      var result = localDb.clearPictures();
      //ASSERT
      expect(() => result, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
