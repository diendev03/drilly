import 'package:drilly/model/transaction.dart';
import 'package:drilly/utils/enum.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String uuid;
  final List<Transaction> transactions;
  final ScreenState status;
  final double incomeTotal;
  final double expenseTotal;
  const HomeState(
      {this.uuid = '',
      this.status = ScreenState.initial,
      this.transactions = const [],
      this.incomeTotal = 0.0,
      this.expenseTotal = 0.0});

  HomeState copyWith(
      {String? uuid,
      List<Transaction>? transactions,
      ScreenState? status,
      double? incomeTotal,
      double? expenseTotal}) {
    return HomeState(
      uuid: uuid ?? this.uuid,
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      incomeTotal: incomeTotal ?? this.incomeTotal,
      expenseTotal: expenseTotal ?? this.expenseTotal,
    );
  }

  @override
  List<Object?> get props =>
      [uuid, transactions, status, incomeTotal, expenseTotal];
}
