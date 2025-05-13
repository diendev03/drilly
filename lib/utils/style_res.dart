import 'package:drilly/utils/color_res.dart';
import 'package:flutter/material.dart';

const boldText = TextStyle(
  color: ColorRes.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const normalText = TextStyle(
  color: ColorRes.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const italicText = TextStyle(
  color: ColorRes.white,
  fontStyle: FontStyle.italic,
  fontSize: 18,
);

// ButtonStyle kButtonThemeStyle = ButtonStyle(
//   backgroundColor: WidgetStateProperty.all(ColorRes.themeColor),
//   shape: WidgetStateProperty.all(
//     const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10))),
//   ),
//   overlayColor: WidgetStateProperty.all(ColorRes.transparent),
// );
//
// InputBorder inputBorder(Color borderColor) {
//   return OutlineInputBorder(
//     borderRadius: const BorderRadius.all(Radius.circular(10)),
//     borderSide: BorderSide(
//         color: borderColor, width: borderColor == Colors.green ? 1 : 0.5),
//   );
// }
