import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_api/core/widgets/generic_circular_progress_indicator.dart';

import '../../widget_setup_to_be_tested.dart';

void main() {
  testWidgets('generic circular progress indicator test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const WidgetSetupToBeTested(child: GenericCircularProgressindicator()));
    await tester.pump(const Duration(seconds: 3));
    final Finder progressIndicatorFinder =
        find.byKey(const Key('generic_circular_progress_indicator'));
    expect(progressIndicatorFinder, findsOneWidget);
  });
}
