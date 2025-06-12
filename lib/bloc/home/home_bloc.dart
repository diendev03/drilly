import 'package:drilly/model/transaction.dart';
import 'package:drilly/service/transaction_service/transaction_service.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/enum.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadHome>((event, emit) async {
      try {
        final uuid =await SharePref().getString(ConstRes.uuid)??"";
        final response = await TransactionService().getAllTransactions(uuid: uuid);
        if (response != null) {
          List<Transaction>transactions = (response.data['data'] as List)
              .map((e) => Transaction.fromJson(e))
              .toList();
          final totals = calculateTotals(transactions);
         emit(state.copyWith(uuid: uuid,status: ScreenState.success,transactions: transactions,
         incomeTotal: totals['income'] ?? 0.0,
         expenseTotal: totals['expense'] ?? 0.0));
        }
      } catch (e) {
        emit(state.copyWith(
          status: ScreenState.error,
        ));
      }
    });
  }
}
Map<String, double> calculateTotals(List<Transaction> transactions) {
  double income = 0;
  double expense = 0;

  for (var t in transactions) {
    final amount = double.tryParse(t.amount.toString()) ?? 0;
    if (t.type == 'income') {
      income += amount;
    } else if (t.type == 'expense') {
      expense += amount;
    }
  }

  return {
    'income': income,
    'expense': expense,
  };
}
