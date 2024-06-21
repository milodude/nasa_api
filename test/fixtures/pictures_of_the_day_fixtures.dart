import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

final List<PictureOfTheDay> mockPicturesList = [
  PictureOfTheDay(
      date: DateTime.now(),
      copyright: 'copyright',
      explanation: 'some explanation',
      title: 'My title',
      url: 'someUrl'),
];

final List<PicturesOfTheDayModel> mockPicturesModelList = [
  PicturesOfTheDayModel(
      date: DateTime.now(),
      copyright: 'copyright',
      explanation: 'some explanation',
      title: 'My title',
      url: 'someUrl'),
];
