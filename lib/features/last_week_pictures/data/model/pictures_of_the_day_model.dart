import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

class PicturesOfTheDayModel extends PictureOfTheDay {
  const PicturesOfTheDayModel(
      {required super.date,
      required super.copyright,
      required super.explanation,
      required super.title,
      required super.url});

  factory PicturesOfTheDayModel.fromJson(Map<String, dynamic> mensaje) {
    return PicturesOfTheDayModel(
      date: (mensaje['date'] as DateTime),
      copyright: mensaje['copyright'],
      explanation: mensaje['explanation'],
      title: mensaje['title'],
      url: mensaje['url'],
    );
  }
}
