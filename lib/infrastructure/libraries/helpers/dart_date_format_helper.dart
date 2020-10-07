import 'package:app/commons/helpers/date_format_helper.dart';
import 'package:intl/intl.dart';

class DartDateFormatHelper implements DateFormatHelper {
  @override
  DateTime parse(String s) {
    return DateFormat('dd/MM/yyyy').parse(s);
  }

  @override
  String toDateString(DateTime dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  String toFullDateString(DateTime dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  }
}
