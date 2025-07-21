// ignore_for_file: unused_import, deprecated_member_use

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drilly/screens/Auth/auth_screen.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/date_res.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'custom/custom_dialog.dart';

class AppRes {
  static void logout() {
    SharePref().clearAll();
    Get.offAll(() => const AuthScreen());
  }

  static Future<SnackbarController?> showSnackBar(String msg,
      {bool type = false}) async {
    if (msg.replaceAll(' ', '').isEmpty) return null;
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: type == false
            ? ColorRes.accent.withOpacity(.35)
            : ColorRes.primary.withOpacity(.25),
        titleText: Container(),
        message: msg,
        messageText: Text(
          msg,
        ),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static Future<void> showCustomLoader() async {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return const CustomLoader();
      },
      barrierDismissible: false,
    );
  }

  static Future<void> hideCustomLoader() async {
    Navigator.of(Get.context!).pop();
  }

  static Future<void> hideCustomLoaderWithBack() async {
    Get.back();
    Get.back();
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<int?> findSelectLanguageCode(List<String> languageCode) async {
    return languageCode.indexOf(SharePref.selectedLanguage);
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> getAppTheme() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<XFile?> pickImage(ImagePicker picker) async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<List<XFile>> pickMultipleImages(ImagePicker? picker) async {
    ImagePicker imagePicker=picker??ImagePicker();
    final List<XFile> images = await imagePicker.pickMultiImage();
    return images;
  }

  Future<Map<String, dynamic>> getDeviceDetails() async {
    final deviceInfo = DeviceInfoPlugin();

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final androidInfo = await deviceInfo.androidInfo;
        return {
          'platform': 'android',
          'deviceId': androidInfo.id,
          'model': androidInfo.model,
          'brand': androidInfo.brand,
        };
      case TargetPlatform.iOS:
        final iosInfo = await deviceInfo.iosInfo;
        return {
          'platform': 'ios',
          'deviceId': iosInfo.identifierForVendor ?? 'unknown',
          'model': iosInfo.utsname.machine,
        };
      case TargetPlatform.windows:
        final winInfo = await deviceInfo.windowsInfo;
        return {
          'platform': 'windows',
          'deviceId': winInfo.deviceId,
          'computerName': winInfo.computerName,
        };
      case TargetPlatform.macOS:
        final macInfo = await deviceInfo.macOsInfo;
        return {
          'platform': 'macos',
          'deviceId': macInfo.systemGUID ?? 'unknown',
          'model': macInfo.model,
        };
      case TargetPlatform.linux:
        final linuxInfo = await deviceInfo.linuxInfo;
        return {
          'platform': 'linux',
          'deviceId': linuxInfo.machineId ?? 'unknown',
        };
      default:
        return {
          'platform': 'unknown',
          'deviceId': 'unknown',
        };
    }
  }
}
