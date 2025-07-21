import 'package:drilly/model/category.dart';
import 'package:drilly/model/transaction.dart';
import 'package:drilly/utils/enum.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String uuid;
  final List<Transaction> transactions;
  final List<Category> categories;
  final ScreenState status;
  final double incomeTotal;
  final double expenseTotal;
  final String startDate;
  final String endDate;
  final bool isIncome;
  final int selCate;
  final List<Transaction> filteredTransactions;
  const HomeState(
      {this.uuid = '',
      this.status = ScreenState.initial,
      this.transactions = const [],
      this.categories = const [],
      this.incomeTotal = 0.0,
      this.expenseTotal = 0.0,
      this.startDate = '',
      this.endDate = '',
      this.isIncome = true,
      this.selCate = 0,
      this.filteredTransactions = const []});

  HomeState copyWith(
      {String? uuid,
      List<Transaction>? transactions,
      List<Category>? categories,
      ScreenState? status,
      double? incomeTotal,
      double? expenseTotal,
      String? startDate,
      String? endDate,
      bool? isIncome,
      int? selCate,
      List<Transaction>? filteredTransactions}) {
    return HomeState(
      uuid: uuid ?? this.uuid,
      transactions: transactions ?? this.transactions,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      incomeTotal: incomeTotal ?? this.incomeTotal,
      expenseTotal: expenseTotal ?? this.expenseTotal,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isIncome: isIncome ?? this.isIncome,
      selCate: selCate ?? this.selCate,
      filteredTransactions: filteredTransactions??[],
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        transactions,
        filteredTransactions,
        categories,
        status,
        incomeTotal,
        expenseTotal,
        startDate,
        endDate,
        isIncome
      ];
}
