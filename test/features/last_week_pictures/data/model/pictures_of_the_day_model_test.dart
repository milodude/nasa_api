import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_api/features/last_week_pictures/data/model/pictures_of_the_day_model.dart';

import '../../../../fixture_reader.dart';

void main() {
  test('Should convert a json to model without any issues', () {
    //ARRANGE
    final decoded =
        json.decode(fixture('pictures_of_the_day/pictures_of_the_day.json'));
    final List<PicturesOfTheDayModel> parsedList = [];
    //ACT
    for (var element in decoded) {
      final item = PicturesOfTheDayModel.fromJson(element);
      parsedList.add(item);
    }
    //ASSERT
    expect(parsedList.length, 7);
  });
}
