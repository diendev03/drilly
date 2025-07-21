import 'package:drilly/model/category.dart';
import 'package:drilly/model/transaction.dart';
import 'package:drilly/service/base_response.dart';
import 'package:drilly/service/category_service/category_service.dart';
import 'package:drilly/service/transaction_service/transaction_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/date_res.dart';
import 'package:drilly/utils/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadHome>((event, emit) async {
      emit(state.copyWith(status: ScreenState.loading));
      String today = DateRes.getToday(), lastWeek = DateRes.getLastWeek();
      try {
        final summaryFuture = TransactionService().getSummary(
            from: DateRes.getStartMonth(), to: DateRes.getEndMonth());
        final txFuture =
            TransactionService().getTransactions(from: lastWeek, to: today);
        final catFuture = CategoryService().getAllCategories();

        final responses = await Future.wait([
          summaryFuture,
          txFuture,
          catFuture,
        ]);

        final summaryRes = responses[0] as BaseResponse<Map<String, dynamic>>;
        final txRes = responses[1] as BaseResponse<List<Transaction>>;
        final catRes = responses[2] as BaseResponse<List<Category>>;

        // Handle errors
        if (summaryRes.data == null) {
          emit(state.copyWith(status: ScreenState.error));
          AppRes.showSnackBar(summaryRes.message);
          return;
        }
        if (txRes.data == null) {
          emit(state.copyWith(status: ScreenState.error));
          AppRes.showSnackBar(txRes.message);
          return;
        }
        if (catRes.data == null) {
          emit(state.copyWith(status: ScreenState.error));
          AppRes.showSnackBar(catRes.message);
          return;
        }

        // Parse numbers only once
        final totalIncome = double.tryParse(
              summaryRes.data!['total_income']?.toString() ?? '0',
            ) ??
            0.0;
        final totalExpense = double.tryParse(
              summaryRes.data!['total_expense']?.toString() ?? '0',
            ) ??
            0.0;

        // Emit a single success state
        emit(state.copyWith(
            status: ScreenState.success,
            incomeTotal: totalIncome,
            expenseTotal: totalExpense,
            transactions: txRes.data!,
            categories: catRes.data!,
            startDate: lastWeek,
            endDate: today,
            filteredTransactions: txRes.data!));
      } catch (e, st) {
        // Optional: log error/st
        emit(state.copyWith(status: ScreenState.error));
        AppRes.showSnackBar('An unexpected error occurred');
      }
    });
    on<FilterTransaction>((event, emit) async {
      List<Transaction> filtered = [];
      bool isIncome = event.isIncome ?? state.isIncome;
      final response=await TransactionService().getTransactions(
        from: event.startDate??state.startDate,
        to: event.endDate??state.endDate,
        type:isIncome ? 'income' : 'expense',
        category: event.category,
      );
      if (response.status == false) {
        AppRes.showSnackBar(response.message);
      }
      filtered= response.data ?? [];
      emit(state.copyWith(
        startDate: event.startDate??state.startDate,
        endDate: event.endDate??state.endDate,
        isIncome: event.isIncome ?? state.isIncome,
        selCate: event.category ?? state.selCate,
        filteredTransactions: filtered,
      ));
  });
  }
}
