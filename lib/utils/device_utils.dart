import 'package:flutter/material.dart';
import 'dart:math';

class DeviceUtils {
  static final DeviceUtils _instance = DeviceUtils._internal();
  bool? _isTablet;
  Size? _screenSize;
  factory DeviceUtils() {
    return _instance;
  }

  DeviceUtils._internal();

  void init(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    final diagonal = sqrt(_screenSize!.width * _screenSize!.width +
        _screenSize!.height * _screenSize!.height);
    _isTablet = diagonal > 1050.0;
  }

  bool get isTablet {
    if (_isTablet == null) {
      return false;
    }
    return _isTablet!;
  }

  double get screenWidth {
    return _screenSize?.width ?? 0.0;
  }

  double get screenHeight {
    return _screenSize?.height ?? 0.0;
  }
}
