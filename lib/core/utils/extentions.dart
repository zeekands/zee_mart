import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

extension StringExtension on String {
  String toCurrencyFormat() {
    return CurrencyFormat.convertToIdr(int.parse(this), 0);
  }

  String toCurrencyWithoutRp() {
    return CurrencyFormat.convertToIdr(int.parse(this), 0).replaceAll('Rp', '');
  }

  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}
