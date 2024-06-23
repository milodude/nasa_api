import 'package:nasa_api/core/providers/sembast_provider.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

class PicturesOfTheDayModel extends PictureOfTheDay implements BaseModel {
  const PicturesOfTheDayModel(
      {required super.date,
      required super.copyright,
      required super.explanation,
      required super.title,
      required super.url});

  factory PicturesOfTheDayModel.fromJson(Map<String, dynamic> message) {
    return PicturesOfTheDayModel(
      date: DateTime.parse((message['date'] as String)),
      copyright: message['copyright'] ?? '',
      explanation: message['explanation'] ?? '',
      title: message['title'] ?? '',
      url: message['url'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'date': date.toString(),
        'copyright': copyright,
        'explanation': explanation,
        'title': title,
        'url': url,
      };
}
