class BudgetModel {
  final int? id;
  final int userId;
  final int categoryId;
  final int month;
  final int year;
  final double amount;

  BudgetModel({
    this.id,
    required this.userId,
    required this.categoryId,
    required this.month,
    required this.year,
    required this.amount,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      month: json['month'],
      year: json['year'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'month': month,
      'year': year,
      'amount': amount,
    };
  }
}
