import 'package:drilly/model/transaction.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionListView({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isIncome = tx.type == 'income';
        final dateFormat = DateFormat('dd/MM/yyyy');

        return ListTile(
          leading: Image.asset(isIncome?AssetRes.icIncome: AssetRes.icExpense, width: 40, height: 40,fit: BoxFit.cover,),
          title: Text(tx.note??""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateFormat.format(tx.transactionDate)),
              if (tx.note?.isNotEmpty == true) Text(tx.note ?? '', style: const TextStyle(fontSize: 12)),
            ],
          ),
          trailing: Text(
            '${isIncome ? '+' : '-'}${formatCurrency(tx.amount)}',
            style: TextStyle(
              color: isIncome ? ColorRes.primary : ColorRes.accent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
