import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../features/auth/data/models/day_model.dart';

class CustomFormatters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\S').format(amount);
  }

  static Timestamp convertTimeOfDayToTimestamp(DayModel day, TimeOfDay time) {
    final selectedDateTime = DateTime(
      day.date!.toDate().year,
      day.date!.toDate().month,
      day.date!.toDate().day,
      time.hour,
      time.minute,
    );
    return Timestamp.fromDate(selectedDateTime);
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

  static Map<Timestamp, dynamic> convertDateTimeMapToTimestamps(Map<DateTime, dynamic> dateTimeMap) {
    Map<Timestamp, dynamic> timestampMap = {};

    for (DateTime dateTime in dateTimeMap.keys) {
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      timestampMap[timestamp] = dateTimeMap[dateTime];
    }

    return timestampMap;
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

  static DateTime convertTimestampToDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return dateTime;
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours $minutes';
  }

  static final hourAndMinute = DateFormat.Hm();  //  21:10
  static final dayAndWeek = DateFormat('d, EEE');  // 2, Sun
  static final yearMonthDay = DateFormat('yMd');  // 6/2/2024
  static final yearAbbrMonthDay = DateFormat('MMMd');  // Jun 2
  static final monthDateYear = DateFormat.yMMMMd('en_US');  //
  static final yearAbbrMonthDayWithTime = DateFormat('EEE, MMM, d').add_Hm();  // Sun, Jun, 2 21:10
}