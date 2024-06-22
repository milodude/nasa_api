import 'package:flutter/material.dart';

import '../../domain/entity/picture_of_the_day.dart';

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
        return Text(pictures[index].title);
      },
    );
  }
}
