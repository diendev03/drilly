// ignore_for_file: unused_import

import 'package:drilly/screens/Auth/auth_screen.dart';
import 'package:drilly/screens/main/main_screen.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/app_utils.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/date_res.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({super.key});

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  String version = "";
  SharePref sharePref = SharePref();

  @override
  void initState() {
    checkAccount();
    super.initState();
  }

  Future<void> checkAccount() async {
    await Future.delayed(const Duration(milliseconds: 500)); // cho logo hiện nhẹ 1 chút
    String token = await sharePref.getString(ConstRes.token) ?? "";

    if (token.isNotEmpty) {
      Get.offAll(() => const MainScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Image(
                      image: AssetImage(AssetRes.logoTransparent),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorRes.transparent,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async => checkAccount(),
                            child: CustomButton(
                              text: S.current.continue_,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FutureBuilder<String>(
                              future: AppRes().getAppVersion(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SpinKitCircle(
                                      color: Colors.blue);
                                } else if (snapshot.hasError) {
                                  return Text(
                                    "Error: ${snapshot.error}",
                                    style: const TextStyle(color: Colors.red),
                                  );
                                } else if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data}",
                                    style: const TextStyle(fontSize: 16),
                                  );
                                } else {
                                  return Text(
                                    DateRes.getToday(
                                        format: DateRes.versionDate),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
