import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CustomFormatters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\S').format(amount);
  }

  static Timestamp? convertDateTimeToTimestamps(DateTime? dateTime) {
    if (dateTime != null) {
      int milliseconds = dateTime.millisecondsSinceEpoch;
      Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(milliseconds);
      return timestamp;
    } else {
      return null;
    }
  }

  static List<Timestamp?> convertDateTimeListToTimestamps(List<DateTime?> dateTimeList) {
    List<Timestamp?> timestampList = [];

    for (DateTime? dateTime in dateTimeList) {
      if (dateTime != null) {
        Timestamp timestamp = Timestamp.fromDate(dateTime);
        timestampList.add(timestamp);
      } else {
        timestampList.add(null);
      }
    }
    return timestampList;
  }

  static List<DateTime?> convertTimestampListToDateTime(List<Timestamp?> timestampList) {
    List<DateTime?> dateTimeList = [];

    for (Timestamp? timestamp in timestampList) {
      if (timestamp != null) {
        DateTime dateTime = timestamp.toDate();
        dateTimeList.add(dateTime);
      } else {
        dateTimeList.add(null);
      }
    }

    return dateTimeList;
  }

  static final dayAndWeek = DateFormat('d, EEE');
  static final yearMonthDay = DateFormat('yMd');
  static final yearAbbrMonthDay = DateFormat('MMMd');
}