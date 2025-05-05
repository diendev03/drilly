// ignore_for_file: unused_import, deprecated_member_use

import 'package:flutter/services.dart';
import 'package:drilly/screens/main/main_screen.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/device_utils.dart';
import 'package:drilly/utils/string_utils.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWithTextFieldWidget extends StatefulWidget {
  final String title;
  final bool isPassword;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;

  const TextWithTextFieldWidget({
    super.key,
    required this.title,
    this.isPassword = false,
    required this.controller,
    this.inputFormatters = const [],
  });

  @override
  State<TextWithTextFieldWidget> createState() =>
      _TextWithTextFieldWidgetState();
}

class _TextWithTextFieldWidgetState extends State<TextWithTextFieldWidget> {
  bool showPassword = false;

  @override
  void initState() {
    showPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: const TextStyle(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: InputBorder.none, // Remove default borders
              // hintText: widget.title,
              // hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: widget.controller.text.isNotEmpty
                            ? ColorRes.primary
                            : ColorRes.black,
                      ),
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorRes.primary, // Color when TextField is focused
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorRes.grey, // Normal border color
                  width: 1.0,
                ),
              ),
            ),
            obscureText: showPassword,
            enableSuggestions: !showPassword,
            autocorrect: !showPassword,
            inputFormatters: widget.inputFormatters,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class CustomCircularInkWell extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;

  const CustomCircularInkWell({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStateProperty.all(ColorRes.transparent),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: child,
    );
  }
}

class ToolBarWidget extends StatelessWidget {
  final String title;
  final Function()? onBack;

  const ToolBarWidget({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.yellow,
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircularInkWell(
              onTap: () {
                if (onBack != null) {
                  onBack!.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical:10,
                ),
                child: Icon(Icons.arrow_back, size: 30,)
              ),
            ),
            Text(
              title,
              // style: kSemiBoldThemeTextStyle.copyWith(
              //   fontSize: DeviceUtils().isTablet ? 22 : 18,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final VoidCallback? action;
  final Color? backgroundColor;
  final double width;
  final double? height;
  final String text;
  final TextStyle textStyle;

  const CustomCard({
    super.key,
    this.backgroundColor = ColorRes.primary,
    this.width = double.infinity,
    this.height,
    this.action,
    required this.text,
    this.textStyle = buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ));
  }
}

class CustomNetworkImage extends StatelessWidget {
  final String url;

  const CustomNetworkImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(AssetRes.chicken, fit: BoxFit.cover);
      },
    );
  }
}