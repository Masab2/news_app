import 'package:intl/intl.dart';

class Utils {
  // Date Fromated
  static String dateFormated(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM:dd:yyyy').format(dateTime).toString();
  }
}
