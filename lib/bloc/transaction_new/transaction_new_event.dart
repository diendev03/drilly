import 'package:drilly/model/category.dart';

abstract class TransactionNewEvent {}

class Initialize extends TransactionNewEvent {}

class SubmitTransaction extends TransactionNewEvent {
  final String name;
  final double amount;
  final String note;
  final String type;
  final String category;
  final String payment;
  final String transactionDate;
  final bool isRecurring;
  final String? repeatCycle;
  final String? location;

  SubmitTransaction({
    required this.name,
    required this.amount,
    required this.note,
    required this.type,
    required this.category,
    required this.payment,
    required this.transactionDate,
    this.isRecurring = false,
    this.repeatCycle,
    this.location,
  });
}

class UpdateSelectedType extends TransactionNewEvent {
  final String? selectedType;
  UpdateSelectedType(this.selectedType);
}

class UpdateSelectedCategory extends TransactionNewEvent {
  final Category? selectedCategory;
  UpdateSelectedCategory(this.selectedCategory);
}

class UpdateSelectedPayment extends TransactionNewEvent {
  final String? selectedPayment;
  UpdateSelectedPayment(this.selectedPayment);
}

class UpdateTransactionDate extends TransactionNewEvent {
  final String transactionDate;
  UpdateTransactionDate(this.transactionDate);
}

class UpdateIsRecurring extends TransactionNewEvent {
  final bool isRecurring;
  UpdateIsRecurring(this.isRecurring);
}

class UpdateRepeatCycle extends TransactionNewEvent {
  final String? repeatCycle;
  UpdateRepeatCycle(this.repeatCycle);
}

class UpdateLocation extends TransactionNewEvent {
  final String? location;
  UpdateLocation(this.location);
}
