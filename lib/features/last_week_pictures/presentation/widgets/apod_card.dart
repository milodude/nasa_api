import 'package:flutter/material.dart';
import '../../domain/entity/picture_of_the_day.dart';

import 'apod_card_image.dart';
import 'apod_card_title.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({super.key, required this.pictureOfTheDay});
  final PictureOfTheDay pictureOfTheDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ApodCardTitle(pictureOfTheDay: pictureOfTheDay),
            const SizedBox(height: 10),
            ApodCardImage(pictureOfTheDay: pictureOfTheDay),
          ],
        ),
      ),
    );
  }
}
