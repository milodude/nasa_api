import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';

final List<PictureOfTheDay> mockPicturesList = [
  PictureOfTheDay(
      date: DateTime.now(),
      copyright: 'copyright1',
      explanation: 'some explanation',
      title: 'Search this',
      url: 'someUrl'),
  PictureOfTheDay(
      date: DateTime.now(),
      copyright: 'copyright1',
      explanation: 'some explanation1',
      title: 'My title1',
      url: 'someUrl1'),
];

final List<PicturesOfTheDayModel> mockPicturesModelList = [
  PicturesOfTheDayModel(
      date: DateTime.now(),
      copyright: 'copyright',
      explanation: 'some explanation',
      title: 'My title',
      url: 'someUrl'),
  PicturesOfTheDayModel(
      date: DateTime.now(),
      copyright: 'copyright1',
      explanation: 'some explanation1',
      title: 'My title1',
      url: 'someUrl1'),
];
