import 'package:app/commons/helpers/date_format_helper.dart';
import 'package:app/ioc/injector.dart';

extension Format on DateTime {
  String format() {
    var dateHelper = Injector.getInstance().resolve<DateFormatHelper>();
    return dateHelper.toFullDateString(this);
  }

  String formatToDate() {
    var dateHelper = Injector.getInstance().resolve<DateFormatHelper>();
    return dateHelper.toDateString(this);
  }
}
