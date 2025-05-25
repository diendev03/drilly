class Transaction {
  final int? id;
  final String? userId;
  final int categoryId;
  final int paymentId;
  final String name;
  final double amount;
  final String type; // 'income' or 'expense'
  final String? note;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final bool isRecurring;
  final String? repeatCycle; // 'daily', 'weekly', 'monthly', 'yearly'
  final String? location;

  Transaction({
    this.id,
    this.userId,
    required this.categoryId,
    required this.paymentId,
    required this.name,
    required this.amount,
    required this.type,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.isRecurring = false,
    this.repeatCycle,
    this.location,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      paymentId: json['payment_id'],
      name: json['name'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      type: json['type'],
      note: json['note'],
      transactionDate: DateTime.parse(json['transaction_date']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      isRecurring: json['is_recurring']==0,
      repeatCycle: json['repeat_cycle'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'payment_id': paymentId,
      'name': name,
      'amount': amount,
      'type': type,
      'note': note,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'is_recurring': isRecurring,
      'repeat_cycle': repeatCycle,
      'location': location,
    };
  }
}
