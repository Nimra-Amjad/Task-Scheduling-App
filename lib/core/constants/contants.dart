import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final day = dateTime.day;
  final month = DateFormat('MMMM').format(dateTime);
  final year = dateTime.year;
  final time = DateFormat('hh:mm a').format(dateTime);

  return '$day $month $year at $time';
}