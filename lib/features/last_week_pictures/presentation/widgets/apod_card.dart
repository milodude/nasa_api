import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/core/constants/widget_keys.dart';
import '../../../../core/constants/pages.dart';
import '../../domain/entity/picture_of_the_day.dart';

import 'apod_card_image.dart';
import 'apod_card_title.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({super.key, required this.pictureOfTheDay});
  final PictureOfTheDay pictureOfTheDay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(apodDetailsPage, arguments: pictureOfTheDay);
      },
      child: Padding(
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
              Hero(
                tag: pictureOfTheDay.url,
                child: ApodCardImage(pictureOfTheDay: pictureOfTheDay),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
