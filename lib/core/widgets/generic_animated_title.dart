import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// GenericAnimatedTitle
///
/// Title with effect. It takes a [child] that animates it.
class GenericAnimatedTitle extends StatelessWidget {
  const GenericAnimatedTitle({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fade(delay: const Duration(milliseconds: 300))
        .slide();
  }
}
