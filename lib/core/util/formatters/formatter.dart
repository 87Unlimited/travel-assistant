import 'package:intl/intl.dart';

class CustomFormatters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\S').format(amount);
  }

  // static String formatPhoneNumber(String phoneNumber) {
  //   if (phoneNumber.length == 8) {
  //     return '(${phoneNumber.substring(0, 3)}) ${phoneNumber}'
  //   }
  // }

  static final dayAndWeek = DateFormat('d, EEE');
  static final yearMonthDay = DateFormat('yMd');
}