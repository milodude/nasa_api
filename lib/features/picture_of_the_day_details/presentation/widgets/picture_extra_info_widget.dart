import 'package:flutter/material.dart';

/// PictureExtraInfoWidget
///
/// Widget to display extra information about the picture taken. It
/// takes two strings a [title] and a [description].
class PictureExtraInfoWidget extends StatelessWidget {
  const PictureExtraInfoWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(description.trim()),
      ],
    );
  }
}
