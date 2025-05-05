// ignore_for_file: unused_import, deprecated_member_use

import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'custom/custom_dialog.dart';

class AppRes {

  static Future<SnackbarController?> showSnackBar(
      String msg,{bool type=false}
      ) async {
    if (msg.replaceAll(' ', '').isEmpty) return null;
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: type==false?ColorRes.accent.withOpacity(.35):ColorRes.primary.withOpacity(.25),
        titleText: Container(),
        // backgroundColor: positive ? ColorRes.white : ColorRes.bitterSweet1,
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
}
