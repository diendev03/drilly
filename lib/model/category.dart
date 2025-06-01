class CategoryModel {
  final int? id;
  final String name;
  final String type; // 'income' or 'expense'
  final String? icon;

  CategoryModel({
    this.id,
    required this.name,
    required this.type,
    this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      icon: json['icons'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'icons': icon,
    };
  }
}
