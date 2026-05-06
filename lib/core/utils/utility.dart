import 'package:intl/intl.dart';

class Utility {
  static String getDateTimeFromUTC(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('E,MMM dd', 'en');
    return dateFormat.format(dateTime);
  }

  static String getDateFromUTC(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd', 'en');
    return dateFormat.format(dateTime);
  }
}
