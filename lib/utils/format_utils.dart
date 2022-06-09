import 'package:intl/intl.dart';

class FormatUtils {
  static String formatAmount(num? amount) {
    if (amount != null) {
      NumberFormat rpFormat = NumberFormat.simpleCurrency(locale: 'in_id');
      return rpFormat
          .format(amount)
          .replaceAll(RegExp('Rp'), 'Rp. ')
          .replaceAll(',00', '');
    }
    return 'Rp. 0';
  }
}
