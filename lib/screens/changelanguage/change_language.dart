import 'package:drilly/main.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  int selectedIndex = 0;
  List<String> languageCode = [
    // 'ar',
    // 'da',
    // 'nl',
    'en',
    // 'fr',
    // 'de',
    // 'el',
    // 'hi',
    // 'id',
    // 'it',
    // 'ja',
    // 'ko',
    // 'nb',
    // 'pl',
    // 'pt',
    // 'ru',
    // 'zh',
    // 'es',
    // 'th',
    // 'tr',
    'vi',
  ];
  int? value = 0;
  List<String> languages = [
    // 'عربي',
    // 'dansk',
    // 'Nederlands',
    'English',
    // 'Français',
    // 'Deutsch',
    // 'Ελληνικά',
    // 'हिंदी',
    // 'bahasa Indonesia',
    // 'Italiano',
    // '日本',
    // '한국인',
    // 'Norsk Bokmal',
    // 'Polski',
    // 'Português',
    // 'Русский',
    // '简体中文',
    // 'Español',
    // 'แบบไทย',
    // 'Türkçe',
    'Tiếng Việt',
  ];
  List<String> subLanguage = [
    // 'Arabic',
    // 'Danish',
    // 'Dutch',
    'English',
    // 'French',
    // 'German',
    // 'Greek',
    // 'Hindi',
    // 'Indonesian',
    // 'Italian',
    // 'Japanese',
    // 'Korean',
    // 'Norwegian Bokmal',
    // 'Polish',
    // 'Portuguese',
    // 'Russian',
    // 'Simplified Chinese',
    // 'Spanish',
    // 'Thai',
    // 'Turkish',
    'Vietnamese',
  ];

  @override
  Future<void> initState() async {
    value = await AppRes.findSelectLanguageCode(languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ToolBarWidget(
            title: S.current.changeLanguage,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index,
                  groupValue: value,
                  activeColor: Theme.of(context).colorScheme.primary,
                  dense: true,
                  onChanged: (value) async {
                    this.value = value as int;
                    await SharePref().saveString(
                      ConstRes.languageCode,
                      languageCode[value],
                    );
                    SharePref.selectedLanguage = languageCode[value];
                    if (context.mounted) {
                      S.of(context);
                    }

                    setState(() {});
                    RestartWidget.restartApp(Get.context!);
                  },
                  title: Text(
                    languages[index],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          // fontFamily: kMediumTextStyle.fontFamily,
                        ),
                  ),
                  subtitle: Text(
                    subLanguage[index],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 14),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
