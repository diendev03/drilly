import 'package:intl/intl.dart';

class DateRes{
  ///DateFormat
  static const String normalDate='dd/MM/yyyy';
  static const String date='yyyy-MM-dd';
  static const String versionDate = 'yy.MM.dd';
  static const String fullDate = 'yyyy-MM-dd HH:mm:ss';
  static const String shortDate = 'MM/yyyy';


  static String getToday({String format = date}) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat(format).format(now);

    return formattedDate;
  }

  static String getStartMonth({String format = date}) {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    return DateFormat(format).format(firstDay);
  }


  static String getEndMonth({String format = date}) {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
    final formatter = DateFormat(format);
    return formatter.format(lastDayOfMonth);
  }

  static String getLastWeek({String format = date}) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return DateFormat(format).format(sevenDaysAgo);
  }
}