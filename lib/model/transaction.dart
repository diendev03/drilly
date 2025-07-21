class Transaction {
  final int? id;
  final int accountId;
  final String type; // 'income' hoặc 'expense'
  final int categoryId;
  final double amount;
  final String? note;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final String? imageUrl;

  Transaction({
    this.id,
    required this.accountId,
    required this.type,
    required this.categoryId,
    required this.amount,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.imageUrl,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['account_id'],
      type: json['type'],
      categoryId: json['category'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      note: json['note'],
      transactionDate: DateTime.parse(json['transaction_date']),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'type': type,
      'category': categoryId,
      'amount': amount,
      'note': note,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'image_url': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Transaction{id: $id, accountId: $accountId, type: $type, categoryId: $categoryId, amount: $amount, note: $note, transactionDate: $transactionDate, createdAt: $createdAt, imageUrl: $imageUrl}';
  }
}
