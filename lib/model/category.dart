class Category {
  final int? id;
  final String name;
  final String type; // 'income' or 'expense'
  final String? icon;

  Category({
    this.id,
    required this.name,
    required this.type,
    this.icon,
  });

  factory Category .fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      icon: json['icon'],
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
