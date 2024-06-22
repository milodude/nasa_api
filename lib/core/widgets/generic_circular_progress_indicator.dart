import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// GenericCircularProgressindicator
///
/// Circular progress indicator used in the app. Has an optional [size]
/// parameter which default value is 70.
class GenericCircularProgressindicator extends StatelessWidget {
  const GenericCircularProgressindicator({
    super.key,
    this.size = 70,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('generic_circular_progress_indicator'),
      child: LoadingAnimationWidget.inkDrop(
        color: Colors.purple,
        size: size!,
      ),
    );
  }
}
