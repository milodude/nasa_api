import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/constants/keys.dart';
import 'package:nasa_api/core/error/exceptions.dart';
import 'package:nasa_api/core/extension/date_extension.dart';
import 'package:nasa_api/core/providers/url_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';

import '../../../../fixture_reader.dart';
import 'apod_data_source_test.mocks.dart';

@GenerateMocks([http.Client, UrlProvider])
void main() {
  MockUrlProvider mockUrlProvider = MockUrlProvider();
  MockClient mockClient = MockClient();
  ApodDataSourceImpl apodDataSource =
      ApodDataSourceImpl(httpClient: mockClient, urlProvider: mockUrlProvider);
  final tPicturesListResponse =
      json.decode(fixture('pictures_of_the_day/pictures_of_the_day.json'));

  final Map<String, String> headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': '*/*',
    'Access-Control-Allow-Origin': '*',
  };

  // String getStartDate() {
  //   DateTime now = DateTime.now();
  //   DateTime pastDate = now.subtract(const Duration(days: 7));
  //   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //   return dateFormat.format(pastDate);
  // }

  List<PicturesOfTheDayModel> getList() {
    List<PicturesOfTheDayModel> photoList = <PicturesOfTheDayModel>[];
    for (Map<String, dynamic> item in tPicturesListResponse) {
      var photo = PicturesOfTheDayModel.fromJson(item);
      photoList.add(photo);
    }
    return photoList;
  }

  final Map<String, String?> params = <String, String?>{
    'start_date': DateTime.now().getWeekBeforeDate,
    'api_key': apiKey,
  };

  void setUpHttpCallSuccess200() {
    final uri = UrlProvider().getUrl('planetary/apod', params);
    when(mockClient.get(uri, headers: headers))
        .thenAnswer((_) async => Future.value(http.Response(
              fixture('pictures_of_the_day/pictures_of_the_day.json'),
              200,
              headers: headers,
            )));
    when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);
    when(mockUrlProvider.getHeaders())
        .thenAnswer((realInvocation) => Future.value(headers));
  }

  group('Http configuration: ', () {
    testWidgets(
        'should perform a get request for a photo list with application/json header',
        (tester) async {
      //Arrange
      setUpHttpCallSuccess200();

      //Act
      await apodDataSource.getLastWeekPicturesOfTheDay();
      //Assert
      verify(mockClient.get(any, headers: headers));
    });
  });

  group('PhotoDataSourceImpl: ', () {
    testWidgets('should get a list of pictures when requesting data to the API',
        (tester) async {
      //Arrange
      setUpHttpCallSuccess200();
      //Act
      var result = await apodDataSource.getLastWeekPicturesOfTheDay();
      //Assert
      expect(result, equals(getList()));
    });

    test(
        'Should throw a serverException when the respond is 404 or other when getting a list of photos',
        () async {
      //ARRANGE
      final uri = UrlProvider().getUrl('planetary/apod', params);
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.get(uri, headers: headers)).thenAnswer(
        (realInvocation) async =>
            http.Response('Something went wrong while getting clients', 404),
      );
      when(mockUrlProvider.getHeaders())
          .thenAnswer((realInvocation) => Future.value(headers));
      apodDataSource = ApodDataSourceImpl(
          urlProvider: mockUrlProvider, httpClient: mockClient);
      //ACT
      final call = apodDataSource.getLastWeekPicturesOfTheDay();
      //ASSERT
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
