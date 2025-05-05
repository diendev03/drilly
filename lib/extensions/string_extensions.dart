import 'package:intl/intl.dart';

extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
  
}

extension NumberFormatting on double {
  String formatNumber(double number) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(this);
  }
}