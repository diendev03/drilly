import 'package:drilly/utils/enum.dart';
import 'package:equatable/equatable.dart';

class TransactionNewState extends Equatable {
  final ScreenState status;
  final String? message;
  final String? errorMessage;

  final DateTime? transactionDate;
  final String? selectedType;
  final String? selectedCategory;
  final String? selectedPayment;

  const TransactionNewState({
    this.status = ScreenState.initial,
    this.message,
    this.errorMessage,
    this.transactionDate,
    this.selectedType,
    this.selectedCategory,
    this.selectedPayment,
  });

  TransactionNewState copyWith({
    ScreenState? status,
    String? message,
    String? errorMessage,
    DateTime? transactionDate,
    String? selectedType,
    String? selectedCategory,
    String? selectedPayment,
  }) {
    return TransactionNewState(
      status: status ?? this.status,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      transactionDate: transactionDate ?? this.transactionDate,
      selectedType: selectedType ?? this.selectedType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPayment: selectedPayment ?? this.selectedPayment,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    errorMessage,
    transactionDate,
    selectedType,
    selectedCategory,
    selectedPayment,
  ];
}
