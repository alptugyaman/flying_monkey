import 'package:intl/intl.dart';

class Utils {
  static String dateToString(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
