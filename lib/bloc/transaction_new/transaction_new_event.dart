abstract class TransactionNewEvent {}

class Initialize extends TransactionNewEvent {}
class SubmitTransaction extends TransactionNewEvent {
  final String name;
  final double amount;
  final String note;
  final String type;
  final String category;
  final String payment;
  final DateTime transactionDate;

  SubmitTransaction({
    required this.name,
    required this.amount,
    required this.note,
    required this.type,
    required this.category,
    required this.payment,
    required this.transactionDate,
  });
}