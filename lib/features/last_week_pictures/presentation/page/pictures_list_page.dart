import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/entity/picture_of_the_day.dart';
import '../widgets/apod_card.dart';

/// PicturesListPage
///
/// Page that renders a list of pictures of the day.
class PicturesListPage extends StatelessWidget {
  const PicturesListPage({super.key, required this.pictures});
  final List<PictureOfTheDay> pictures;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pictures.length,
      itemBuilder: (BuildContext context, int index) {
        return ApodCard(pictureOfTheDay: pictures[index])
            .animate(delay: Duration(milliseconds: 100 * index))
            .slide(begin: Offset.fromDirection(0, 1), curve: Curves.easeIn);
      },
    );
  }
}
