// ignore_for_file: unused_import

import 'package:drilly/utils/color_res.dart';
import 'package:flutter/material.dart';
class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
