import 'package:drilly/utils/date_res.dart';
import 'package:flutter/material.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/string_res.dart';

class Overview extends StatelessWidget {
  final double expenseTotal;
  final double incomeTotal;

  const Overview({
    super.key,
    required this.expenseTotal,
    required this.incomeTotal,
  });

  @override
  Widget build(BuildContext context) {
    final total = expenseTotal + incomeTotal;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${S.current.overview} ${DateRes.getToday(format: DateRes.shortDate)}", style: StyleRes.header),
          const SizedBox(height: 15),
          // Expense row
          SizedBox(
            height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 55,
                  child: Text(S.current.expense),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: total == 0 ? 0 : expenseTotal / total,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(color: ColorRes.accent),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 35,
                  child: Text(formatCurrency(expenseTotal)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Income row
          SizedBox(
            height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 55,
                  child: Text(S.current.income),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: total == 0 ? 0 : incomeTotal / total,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(color: ColorRes.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 35,
                  child: Text(formatCurrency(incomeTotal)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
