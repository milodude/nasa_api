import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_api/core/extension/date_extension.dart';

void main() {
  final DateTime testDate = DateTime(2024, 06, 22, 12, 30, 34);
  group('${testDate.runtimeType} extension tests', () {
    test('should get the date from a week before', () {
      final String result = testDate.getWeekBeforeDate;
      expect('2024-06-15', result);
    });

    test('should get the date in a formatted way', () {
      final String result = testDate.formatDate;
      expect('22-06-2024', result);
    });
  });
}
