import 'package:intl/intl.dart';

class CurrencyUtils {
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return NumberFormat('#,##0.00', 'en_US').format(amount);
  }

  static String formatCurrencyWithSymbol(double amount, {String symbol = '\$'}) {
    return '$symbol${formatCurrency(amount)}';
  }

  static double parseAmount(String amount) {
    try {
      return double.parse(amount.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (e) {
      return 0.0;
    }
  }

  static String getPercentage(double current, double total) {
    if (total == 0) return '0%';
    return '${((current / total) * 100).toStringAsFixed(1)}%';
  }
}
