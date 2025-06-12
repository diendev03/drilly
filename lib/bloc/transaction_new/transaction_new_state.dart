import 'package:drilly/model/category.dart';
import 'package:drilly/utils/enum.dart';
import 'package:equatable/equatable.dart';

class TransactionNewState extends Equatable {
  final ScreenState status;
  final String? message;
  final String? errorMessage;

  final String? transactionDate;
  final String? selectedType;
  final List<Category>categories;
  final Category? selectedCategory;
  final String? selectedPayment;
  final bool isRecurring;
  final String? isRepeatCycle;

  const TransactionNewState({
    this.status = ScreenState.initial,
    this.message,
    this.errorMessage,
    this.transactionDate,
    this.selectedType,
    this.categories = const [],
    this.selectedCategory,
    this.selectedPayment,
    this.isRecurring = false,
    this.isRepeatCycle,
  });

  TransactionNewState copyWith({
    ScreenState? status,
    String? message,
    String? errorMessage,
    String? transactionDate,
    String? selectedType,
    List<Category>? categories,
    Category? selectedCategory,
    String? selectedPayment,
    bool? isRecurring,
    String? isRepeatCycle,
  }) {
    return TransactionNewState(
      status: status ?? this.status,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      transactionDate: transactionDate ?? this.transactionDate,
      selectedType: selectedType ?? this.selectedType,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isRecurring: isRecurring ?? this.isRecurring,
      isRepeatCycle: isRepeatCycle ?? this.isRepeatCycle,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    errorMessage,
    transactionDate,
    selectedType,
    categories,
    selectedCategory,
    selectedPayment,
    isRecurring,
    isRepeatCycle,
  ];
}
