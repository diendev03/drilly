// ignore_for_file: unused_import, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
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
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                    vertical: 10,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
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

class CustomButton extends StatelessWidget {
  final VoidCallback? action;
  final Color? backgroundColor;
  final double width;
  final double? height;
  final String text;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    this.backgroundColor = ColorRes.primary,
    this.width = double.infinity,
    this.height,
    this.action,
    required this.text,
    this.textStyle = boldText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Text(
            text,
            style: textStyle,
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

class DropdownAction {
  final String title;
  final IconData icon;
  final VoidCallback action;

  DropdownAction({
    required this.title,
    required this.icon,
    required this.action,
  });
}

class CustomDropdownMenu extends StatelessWidget {
  final List<DropdownAction> actions;
  final Widget child;

  const CustomDropdownMenu({
    super.key,
    required this.actions,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return GestureDetector(
      key: buttonKey, // Gán GlobalKey cho ElevatedButton
      onTap: () {
        final RenderBox renderBox =
            buttonKey.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(position.dx,
              position.dy + renderBox.size.height, position.dx, 0.0),
          items: actions.map((DropdownAction action) {
            return PopupMenuItem<DropdownAction>(
              value: action,
              child: Row(
                children: [
                  Icon(action.icon, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(action.title),
                ],
              ),
            );
          }).toList(),
        ).then((value) {
          if (value != null) {
            value.action();
          }
        });
      },
      child: child,
    );
  }
}

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;

  const ImageFromUrl({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.black,
      appBar: AppBar(
        backgroundColor: ColorRes.black,
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const CircularProgressIndicator(), // Hiển thị placeholder trong khi tải ảnh
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Hiển thị nếu có lỗi khi tải ảnh
          fit: BoxFit.cover, // Tùy chọn kiểu fit cho ảnh
        ),
      ),
    );
  }
}
