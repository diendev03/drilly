// lib/utils/text_styles.dart
import 'package:drilly/utils/color_res.dart';
import 'package:flutter/material.dart';

class StyleRes {
  StyleRes._(); // private constructor – không cho instantiate

  // Các style const, có thể dùng trong const constructors
  static const TextStyle header = TextStyle(
    color: ColorRes.primary,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle subHeader = TextStyle(
    color: ColorRes.primary,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle content = TextStyle(
    color: ColorRes.primary,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static const TextStyle note = TextStyle(
    color: ColorRes.primary,
    fontStyle: FontStyle.italic,
    fontSize: 12,
  );

  // Static methods để override màu, trả về TextStyle không phải const
  static TextStyle headerColored(Color color) => header.copyWith(color: color);
  static TextStyle subHeaderColored(Color color) => subHeader.copyWith(color: color);
  static TextStyle contentColored(Color color) => content.copyWith(color: color);
  static TextStyle noteColored(Color color) => note.copyWith(color: color);
}
