import 'package:drilly/model/category.dart';
import 'package:drilly/service/category_service/category_service.dart';
import 'package:drilly/service/transaction_service/transaction_service.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/enum.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_new_event.dart';
import 'transaction_new_state.dart';

class TransactionNewBloc
    extends Bloc<TransactionNewEvent, TransactionNewState> {
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController amountEC = TextEditingController();
  final TextEditingController locationEC = TextEditingController();
  final TextEditingController noteEC = TextEditingController();

  TransactionNewBloc() : super(const TransactionNewState()) {
    on<Initialize>((event, emit) async {
      String? uuid = await SharePref().getString(ConstRes.uuid);
      if (uuid != null) {
        final categoriesResponse =
            await CategoryService().getAllCategories(uuid: uuid);
        print("Categories Response: ${categoriesResponse?.data["data"]}");
        List<Category> categories = [];
        if (categoriesResponse != null && categoriesResponse.data != null) {
          categories = (categoriesResponse.data["data"] as List).map((e) => Category.fromJson(e))
              .toList();
        }
        emit(state.copyWith(categories: categories));
      }
    });

    on<UpdateSelectedType>((event, emit) {
      emit(state.copyWith(selectedType: event.selectedType));
    });

    on<UpdateSelectedCategory>((event, emit) {
      emit(state.copyWith(selectedCategory: event.selectedCategory));
    });

    on<UpdateSelectedPayment>((event, emit) {
      emit(state.copyWith(selectedPayment: event.selectedPayment));
    });

    on<UpdateTransactionDate>((event, emit) {
      emit(state.copyWith(transactionDate: event.transactionDate));
    });

    on<UpdateIsRecurring>((event, emit) {
      emit(state.copyWith(isRecurring: event.isRecurring));
    });

    on<UpdateRepeatCycle>((event, emit) {
      emit(state.copyWith(isRepeatCycle: event.repeatCycle));
    });

    on<UpdateLocation>((event, emit) {
      // emit(state.copyWith(location: event.location));
    });

    on<SubmitTransaction>((event, emit) async {
      String? uuid = await SharePref().getString(ConstRes.uuid) ?? "";

      if (uuid.isEmpty) {
        print("UUID không hợp lệ");
        emit(state.copyWith(
          status: ScreenState.error,
          message: null,
          errorMessage: "UUID không hợp lệ",
        ));
        return;
      }
      final response = await TransactionService().createTransaction(
        uuid: uuid,
        categoryId: "1",
        paymentId: "1",
        // categoryId: event.category,
        // paymentId: event.payment,
        name: event.name,
        amount: event.amount,
        type: event.type.toLowerCase(),
        note: event.note,
        transactionDate: event.transactionDate,
        isRecurring: event.isRecurring,
        repeatCycle: event.repeatCycle,
        location: event.location ?? '',
      );
      if (response != null) {
        emit(state.copyWith(
          status: ScreenState.success,
          message: "Tạo giao dịch thành công",
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          status: ScreenState.error,
          message: null,
          errorMessage: "Tạo giao dịch thất bại",
        ));
      }
    });
  }

  void dispose() {
    nameEC.dispose();
    amountEC.dispose();
    noteEC.dispose();
    locationEC.dispose();
  }
  List<Category> getCategoriesByType(List<Category> all,String type) {
    List<Category> filteredCategories = [];
    for(Category category in all) {
      if (category.type == type) {
        filteredCategories.add(category);
      }
    }
    return filteredCategories;
  }

}
