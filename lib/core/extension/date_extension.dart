import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  /// getWeekBeforeDate
  ///
  /// Method to return a formatted string minus 7days from today
  String get getWeekBeforeDate {
    DateTime now = DateTime.now();
    DateTime pastDate = now.subtract(const Duration(days: 7));
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(pastDate);
  }

  String get formatDate {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return dateFormat.format(this);
  }
}
