import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nasa_api/core/extension/date_extension.dart';
import 'package:nasa_api/core/widgets/generic_animated_title.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';
import 'package:nasa_api/features/picture_of_the_day_details/presentation/widgets/picture_extra_info_widget.dart';
import 'package:nasa_api/generated/l10n.dart';

import '../../../last_week_pictures/presentation/widgets/apod_card_image.dart';

/// PictureOfTheDayDetailsPage
///
/// Page that displays more information about a taken picture.
class PictureOfTheDayDetailsPage extends StatelessWidget {
  const PictureOfTheDayDetailsPage({super.key, required this.picture});
  final PictureOfTheDay picture;

  @override
  Widget build(BuildContext context) {
    final Widget divider = SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: const Divider(
        thickness: 3,
      ),
    );
    final AppLocalizations intl = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GenericAnimatedTitle(
          child: Text(intl.pictureDetailsTitle),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Hero(
              tag: picture.url,
              child: ApodCardImage(pictureOfTheDay: picture),
            ),
            const SizedBox(height: 10),
            divider,
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PictureExtraInfoWidget(
                  title: intl.dateTaken,
                  description: picture.date.formatDate,
                ).animate(delay: const Duration(milliseconds: 200)).slide(
                    begin: Offset.fromDirection(0, 4), curve: Curves.easeIn),
                PictureExtraInfoWidget(
                  title: intl.copyright,
                  description: picture.copyright,
                ).animate(delay: const Duration(milliseconds: 400)).slide(
                    begin: Offset.fromDirection(0, 4), curve: Curves.easeIn),
              ],
            ),
            divider,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        picture.explanation,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
