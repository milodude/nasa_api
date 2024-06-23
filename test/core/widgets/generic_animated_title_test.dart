import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_api/core/widgets/generic_animated_title.dart';

import '../../widget_setup_to_be_tested.dart';

void main() {
  testWidgets('generic circular progress indicator test',
      (WidgetTester tester) async {
    const data = 'data';
    await tester.pumpWidget(const WidgetSetupToBeTested(
        child: GenericAnimatedTitle(
      child: Text(data),
    )));
    await tester.pump(const Duration(seconds: 3));
    final Finder genericAnimatedTitle = find.text(data);
    expect(genericAnimatedTitle, findsOneWidget);
  });
}
