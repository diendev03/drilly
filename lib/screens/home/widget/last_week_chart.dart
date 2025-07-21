import 'dart:async';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:drilly/model/transaction.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/string_res.dart';

class LastWeekChart extends StatefulWidget {
  final List<Transaction> transactions;

  const LastWeekChart({super.key, required this.transactions});

  @override
  State<LastWeekChart> createState() => _LastWeekChartState();
}

class _LastWeekChartState extends State<LastWeekChart> {
  bool _showNoData = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Nếu list rỗng, chờ 3s rồi hiện “no data”
    if (widget.transactions.isEmpty) {
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _showNoData = true);
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transactions.isEmpty && !_showNoData) {
      return const SizedBox(
        height: 200,
        child: Center(child: MyLoading()),
      );
    }

    if (widget.transactions.isEmpty && _showNoData) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            S.current.youDoNotHaveAnyTransactionYet,
            style: StyleRes.content,
          ),
        ),
      );
    }

    final today = DateTime.now();
    final days = List.generate(7, (i) {
      final d = today.subtract(Duration(days: 6 - i));
      return DateTime(d.year, d.month, d.day);
    });

    final incomeMap = {for (var d in days) d: 0.0};
    final expenseMap = {for (var d in days) d: 0.0};
    for (var tx in widget.transactions) {
      final d = DateTime(tx.transactionDate.year,
          tx.transactionDate.month, tx.transactionDate.day);
      if (incomeMap.containsKey(d)) {
        if (tx.type == 'income') {
          incomeMap[d] = incomeMap[d]! + tx.amount;
        } else {
          expenseMap[d] = expenseMap[d]! + tx.amount;
        }
      }
    }

    final maxY = [
      ...incomeMap.values,
      ...expenseMap.values,
    ].fold<double>(0, (prev, v) => v > prev ? v : prev);

    final groups = List.generate(days.length, (i) {
      final inc = incomeMap[days[i]]!;
      final exp = expenseMap[days[i]]!;
      return BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: inc,
            color: ColorRes.primary,
            width: 12,
            borderRadius: BorderRadius.circular(6),
          ),
          BarChartRodData(
            toY: exp,
            color: ColorRes.accent,
            width: 12,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),

      ),
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: BarChart(
          BarChartData(
            maxY: maxY * 1.1,
            barGroups: groups,
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) =>
                  FlLine(color: Colors.grey.shade200, strokeWidth: 1),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: maxY /5,
                  getTitlesWidget: (v, _) => Text(
                    formatCurrency(v),
                    style:
                    const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 25,
                  getTitlesWidget: (v, _) {
                    final idx = v.toInt();
                    if (idx < days.length) {
                      return Text(
                        DateFormat.E().format(days[idx]),
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black54),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIdx, rod, rodIdx) {
                  final label = rodIdx == 0 ? 'Income' : 'Expense';
                  return BarTooltipItem(
                    '$label\n${formatCurrency(rod.toY)}',
                    const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
