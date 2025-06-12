// ignore_for_file: deprecated_member_use, unused_import

import 'package:drilly/utils/const_res.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/style_res.dart';

class DateTimeUtils {
  static String getCurrentDate({String format = ConstRes.normalDate}) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat(format).format(now);

    return formattedDate;
  }

  static const String customFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String formatTime = 'hh:mm a';
  static const String formatDate = 'MMM. d, yyyy';
  static const String formatDateHaft = 'MMM. d';
  static const String formatFull = 'hh:mm a EE, MMM. dd, yyyy';
  static const String formatHaft = 'EE, MMM. dd, yyyy';
  static const String formatDateTime = 'hh:mm a EE, MMM. dd';

  static String getStringTime(String? date) {
    final dateTime = getDateTime(date);
    if (dateTime != null) {
      return DateFormat(formatTime).format(dateTime);
    }
    return '';
  }

  static String getStringDate(String? date) {
    final dateTime = getDateTime(date);
    if (dateTime != null) {
      return DateFormat(formatHaft).format(dateTime);
    }
    return '';
  }

  static DateTime? getDateTime(String? date) {
    try {
      return DateTime.parse(date ?? '');
    } catch (_) {
      try {
        return DateFormat(customFormat).parse(date ?? '');
      } catch (_) {
        return null;
      }
    }
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String formatDateTimeWithDay(String date) {
    final dateTime = getDateTime(date);
    if (dateTime == null) {
      return date;
    }
    final DateFormat formatter = DateFormat(formatFull);
    return formatter.format(dateTime);
  }

  static String convertTimeOfDayToDateTime(TimeOfDay time) {
    final date = DateTime(
      1999,
      05,
      13,
      time.hour,
      time.minute,
    );
    return DateFormat('HH:mm:ss').format(date);
  }

  static String getDateTimeString(DateTime dt) {
    return DateFormat(customFormat).format(dt);
  }

  static String getRangeDate(DateTime startDate, DateTime endDate) {
    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      return DateFormat(formatDate).format(startDate);
    } else if (startDate.year == endDate.year) {
      return '${DateFormat(formatDateHaft).format(startDate)} -> ${DateFormat(formatDate).format(endDate)}';
    } else {
      return '${DateFormat(formatDate).format(startDate)} -> ${DateFormat(formatDate).format(endDate)}';
    }
  }

  static Future<DateTimeRange?> pickerDateTimeRanger(
    BuildContext context, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final picked = await showDateRangePicker(
        context: context,
        lastDate: DateTime.now(),
        firstDate: DateTime(1900),
        keyboardType: TextInputType.datetime,
        initialDateRange: DateTimeRange(
          start: startDate,
          end: endDate,
        ),
      );
      if (picked != null) {
        return picked;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<TimeOfDay?> pickerTime(
    BuildContext context,
    String time,
  ) async {
    try {
      final date = getDateTime(time) ?? DateTime.now();
      return await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: date.hour,
          minute: date.minute,
        ),
        initialEntryMode: TimePickerEntryMode.dialOnly,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                // primary: ColorRes.themeColor,
                onPrimary: Colors.redAccent,
              ),
            ),
            child: child!,
          );
        },
      );
    } catch (_) {
      return null;
    }
  }

  static String getMinTimeString(List<String> timeStrings) {
    try {
      List<DateTime> times = timeStrings.map((timeString) {
        List<String> parts = timeString.split(":");
        int hours = int.parse(parts[0]);
        int minutes = int.parse(parts[1]);
        return DateTime(0, 1, 1, hours, minutes);
      }).toList();

      DateTime minTime = times.reduce((a, b) => a.isBefore(b) ? a : b);

      String minTimeString =
          "${minTime.hour.toString().padLeft(2, '0')}:${minTime.minute.toString().padLeft(2, '0')}:00";
      return minTimeString;
    } catch (_) {
      return '00:00:00';
    }
  }

  static int subDateTime(DateTime date1, DateTime date2) {
    return date1.difference(date2).inDays;
  }

  static String formatDateString(dynamic date, {String format = formatDate}) {
    if (date == null) return '';
    try {
      final DateTime parsedDate =
          date is String ? DateTime.parse(date) : date as DateTime;
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return '';
    }
  }
}
