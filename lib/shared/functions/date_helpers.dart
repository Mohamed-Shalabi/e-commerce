import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get formatted => DateFormat('yyyy-MM-dd', 'En-US').format(this);

  DateTime get withoutTime => DateTime(year, month, day);

  static DateTime get today => DateTime.now().withoutTime;
}

DateTime parseDate(String dateString) {
  return DateFormat('yyyy-MM-dd', 'En-US').parse(dateString);
}
