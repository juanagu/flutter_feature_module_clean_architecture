import 'package:app/commons/helpers/price_format_helper.dart';

class CustomPriceFormatHelper implements PriceFormatHelper {
  @override
  String format(double price) {
    return price.toInt().toString();
  }

  @override
  String withCurrency(double price) {
    return '\$ ${format(price)}';
  }
}
