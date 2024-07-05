import 'package:nasa_api/core/providers/debug_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/providers/sembast_provider.dart';

abstract class LocalPicturesOfTheDayDataSource {
  Future<void> addPictures(List<PicturesOfTheDayModel> pictures);
  Future<List<PicturesOfTheDayModel>> getPictures();
  Future<void> clearPictures();
}

class LocalPicturesOfTheDayDataSourceImpl
    implements LocalPicturesOfTheDayDataSource {
  final SembastProvider sembastProvider;

  LocalPicturesOfTheDayDataSourceImpl({required this.sembastProvider});

  @override
  Future<void> addPictures(List<PicturesOfTheDayModel> pictures) async {
    try {
      DebugProvider.debugLog('$runtimeType - Inserting pictures into local DB');
      for (var element in pictures) {
        await sembastProvider.insert<PicturesOfTheDayModel>(element);
      }
    } catch (error) {
      DebugProvider.debugLog(
          '$runtimeType - Error while trying to add pictures: $error');
      throw ServerException();
    }
  }

  @override
  Future<List<PicturesOfTheDayModel>> getPictures() async {
    try {
      final Iterable<PicturesOfTheDayModel> result = await sembastProvider
          .getAll<PicturesOfTheDayModel>(PicturesOfTheDayModel.fromJson);
      return result.toList();
    } catch (error) {
      DebugProvider.debugLog(
          '$runtimeType - Error while trying to get the local pictures: $error');
      throw LocalServerException();
    }
  }

  @override
  Future<void> clearPictures() async {
    try {
      return sembastProvider.clear<PicturesOfTheDayModel>();
    } catch (error) {
      DebugProvider.debugLog(
          '$runtimeType - Error while trying to clear the local pictures: $error');
      throw ServerException();
    }
  }
}
