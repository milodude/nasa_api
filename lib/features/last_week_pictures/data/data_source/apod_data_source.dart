import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_api/core/extension/date_extension.dart';
import 'package:nasa_api/core/providers/url_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/providers/debug_provider.dart';
import 'package:http/http.dart' as http;

/// ApodDataSource
///
/// Abstract class that defines the contract for the picture of the day data source
abstract class ApodDataSource {
  Future<List<PicturesOfTheDayModel>> getLastWeekPicturesOfTheDay();
}

/// ApodDataSourceImpl
///
/// Implementation for the picture of the day data source.
/// 1 - [getLastWeekPicturesOfTheDay] - Gets the pictures from the last week.
class ApodDataSourceImpl implements ApodDataSource {
  final UrlProvider urlProvider;
  final http.Client httpClient;

  ApodDataSourceImpl({
    required this.urlProvider,
    required this.httpClient,
  });

  @override
  Future<List<PicturesOfTheDayModel>> getLastWeekPicturesOfTheDay() async {
    DebugProvider.debugLog('[$runtimeType] - Getting images from source...');
    final Map<String, String?> params = <String, String?>{
      'start_date': DateTime.now().getWeekBeforeDate,
      'api_key':  dotenv.env['API_KEY'],
    };
    final Uri uri = urlProvider.getUrl('planetary/apod/', params);

    final Map<String, String> headers = await urlProvider.getHeaders();
    final http.Response response = await httpClient.get(uri, headers: headers);
    DebugProvider.debugLog(
        '[$runtimeType] - Getting server response with code: ${response.statusCode}');
    if (response.statusCode == 200) {
      DebugProvider.debugLog('[$runtimeType] Parsing information...');
      final dynamic decodedJson = json.decode(response.body);
      final List<PicturesOfTheDayModel> picturesList =
          <PicturesOfTheDayModel>[];
      for (final dynamic item in decodedJson) {
        final PicturesOfTheDayModel pedido =
            PicturesOfTheDayModel.fromJson(item as Map<String, dynamic>);
        picturesList.add(pedido);
      }
      return picturesList;
    } else {
      throw ServerException();
    }
  }
}
