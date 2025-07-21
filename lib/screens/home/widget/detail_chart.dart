import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/string_res.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/model/transaction.dart';
import 'package:drilly/model/category.dart';

class DetailTransactionChart extends StatefulWidget {
  final List<Transaction> transactions;
  final List<Category> categories;
  final double size;

  const DetailTransactionChart({
    Key? key,
    required this.transactions,
    required this.categories,
    this.size = 180,
  }) : super(key: key);

  @override
  DetailTransactionChartState createState() => DetailTransactionChartState();
}

class DetailTransactionChartState extends State<DetailTransactionChart> {
  int? _touchedIndex;
  bool _timeout = false;

  // Palette 20 màu
  static const _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black26,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _timeout = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nếu chưa có data đầu vào thì loading
    if (widget.transactions.isEmpty || widget.categories.isEmpty) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Center(
          child: _timeout
              ? Text(S.current.youDoNotHaveAnyTransactionYet, style: StyleRes.content)
              : const MyLoading(),
        ),
      );
    }

    // 1) Tính tổng theo categoryId
    final sums = <int, double>{};
    for (final tx in widget.transactions) {
      sums[tx.categoryId] = (sums[tx.categoryId] ?? 0) + tx.amount;
    }

    // 2) Map sums -> entries (vẫn giữ cả phần "Unknown" nếu category thiếu)
    final entries = sums.entries
        .map((kv) {
          final cat = widget.categories.firstWhere(
            (c) => c.id == kv.key,
            orElse: () => Category(
              id: kv.key,
              name: 'Unknown',
              type: 'expense',
              isGlobal: false,
            ),
          );
          return _Entry(category: cat, amount: kv.value);
        })
        .where((e) => e.amount > 0)
        .toList();

    // Nếu không có entry nào > 0 → empty state
    if (entries.isEmpty) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: const Center(child: Text('No data to display')),
      );
    }

    // 3) Tính tổng chung để chia %
    final total = entries.fold<double>(0, (sum, e) => sum + e.amount);

    // 4) Tạo sections cho PieChart
    final sections = List<PieChartSectionData>.generate(entries.length, (i) {
      final e = entries[i];
      final percent = total > 0 ? e.amount / total * 100 : 0.0;
      final isTouched = i == _touchedIndex;
      return PieChartSectionData(
        color: e.category.color ?? _defaultColors[i % _defaultColors.length],
        value: e.amount,
        showTitle: true,
        title: '${percent.toStringAsFixed(0)}%',
        radius: widget.size * (isTouched ? 0.45 : 0.40),
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: widget.size * 0.25,
                  sections: sections,
                  pieTouchData: PieTouchData(touchCallback: (e, resp) {
                    if (!e.isInterestedForInteractions ||
                        resp?.touchedSection == null) {
                      setState(() => _touchedIndex = null);
                    } else {
                      setState(() => _touchedIndex =
                          resp!.touchedSection!.touchedSectionIndex);
                    }
                  }),
                ),
                swapAnimationDuration: const Duration(milliseconds: 400),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
            const Spacer(),
            Wrap(
              direction: Axis.vertical,
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              children: List.generate(entries.length, (i) {
                final e = entries[i];
                final color = e.category.color ??
                    _defaultColors[i % _defaultColors.length];
                final isTouched = i == _touchedIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(isTouched ? 4 : 2),
                  decoration: BoxDecoration(
                    color:
                        isTouched ? color.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                          )),
                      const SizedBox(width: 4),
                      Text(
                        '${e.category.name} - ${formatCurrency(e.amount)}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isTouched ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ));
  }
}

class _Entry {
  final Category category;
  final double amount;
  _Entry({required this.category, required this.amount});
}
