import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';

abstract class ApodDataSource {
  Future<List<PicturesOfTheDayModel>> getLastWeekPicturesOfTheDay();
}

class ApodDataSourceImpl implements ApodDataSource {
  @override
  Future<List<PicturesOfTheDayModel>> getLastWeekPicturesOfTheDay() {
    throw UnimplementedError();
  }
}
