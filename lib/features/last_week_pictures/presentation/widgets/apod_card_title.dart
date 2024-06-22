import 'package:flutter/material.dart';

import '../../domain/entity/picture_of_the_day.dart';

class ApodCardTitle extends StatelessWidget {
  const ApodCardTitle({
    super.key,
    required this.pictureOfTheDay,
  });

  final PictureOfTheDay pictureOfTheDay;

  @override
  Widget build(BuildContext context) {
    return Text(
      pictureOfTheDay.title,
      style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    );
  }
}
