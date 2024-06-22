import 'package:flutter/material.dart';
import 'package:nasa_api/generated/l10n.dart';

import '../../../../core/widgets/generic_circular_progress_indicator.dart';
import '../../domain/entity/picture_of_the_day.dart';

class ApodCardImage extends StatelessWidget {
  const ApodCardImage({
    super.key,
    required this.pictureOfTheDay,
  });

  final PictureOfTheDay pictureOfTheDay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Image.network(
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              AppLocalizations.of(context).imageNotAvailable,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : const GenericCircularProgressindicator(size: 30);
          },
          pictureOfTheDay.url,
        ),
      ),
    );
  }
}
