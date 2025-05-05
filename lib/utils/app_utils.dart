import 'dart:io';

import 'package:flutter/material.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/shared_pref.dart';

class AppUtils {
  static Future<bool> checkConnectionInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Locale getLocale() {
    final lang =  (SharePref().getString(ConstRes.languageCode));
    final locale = Locale(lang.toString());
    if ([const Locale('en'), const Locale('vi')].contains(locale)) {
      return locale;
    }
    return const Locale('en');
  }

  static Future<String> getLangCode() async{
    final lang =await SharePref().getString(ConstRes.languageCode);
    return lang == 'vi' ? 'vn' : 'en';
  }
}
