import 'package:flutter/material.dart';

class Category {
  final int? id;
  final String name;
  final String type;       // 'income' hoặc 'expense'
  final String? icon;      // URL icon
  final Color? color;      // parsed từ hex string
  final bool isGlobal;     // is_global = 0/1
  final int? ownerId;
  final int? approvedBy;
  final DateTime? createdAt;

  Category({
    this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    required this.isGlobal,
    this.ownerId,
    this.approvedBy,
    this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    Color? parsedColor;
    if (json['color'] != null) {
      final hex = (json['color'] as String).replaceFirst('#', '');
      parsedColor = Color(int.parse('0xFF$hex'));
    }

    return Category(
      id: json['id'] as int?,
      name: json['name'] as String,
      type: json['type'] as String,
      icon: json['icon'] as String?,
      color: parsedColor,
      isGlobal: (json['is_global'] as int?) == 1,
      ownerId: json['owner_id'] as int?,
      approvedBy: json['approved_by'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    String? colorHex;
    if (color != null) {
      colorHex =
      '#${color!.value.toRadixString(16).padLeft(8, '0').substring(2)}';
    }

    return {
      'id': id,
      'name': name,
      'type': type,
      'icon': icon,
      'color': colorHex,
      'is_global': isGlobal ? 1 : 0,
      'owner_id': ownerId,
      'approved_by': approvedBy,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
