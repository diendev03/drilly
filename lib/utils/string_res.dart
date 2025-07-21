String formatCurrency(double value) {
  String format(double v) =>
      v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

  if (value >= 1e9) return '${format(value / 1e9)}B'; // tỷ
  if (value >= 1e6) return '${format(value / 1e6)}M'; // triệu
  if (value >= 1e3) return '${format(value / 1e3)}K'; // nghìn
  return format(value);
}

