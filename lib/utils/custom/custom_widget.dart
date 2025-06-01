// ignore_for_file: unused_import, deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:drilly/screens/main/main_screen.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BaseScreen extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;

  const BaseScreen({
    super.key,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: body,
        ),
      ),
    );
  }
}

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

class XFileImageWidget extends StatelessWidget {
  final XFile? xFile;
  final double width;
  final double height;

  const XFileImageWidget({
    super.key,
    required this.xFile,
    this.width = 100,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    if (xFile == null) {
      // Nếu chưa có ảnh, hiển thị placeholder
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 40, color: Colors.grey),
      );
    }

    return Image.file(
      File(xFile!.path),
      width: width,
      height: height,
      fit: BoxFit.cover,
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

class DatePicker extends StatefulWidget {
  final String? initialDate;
  final ValueChanged<String> onDateChanged;

  const DatePicker({
    super.key,
    this.initialDate,
    required this.onDateChanged,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  DateTime _parseDate(String? dateStr) {
    if (dateStr == null) {
      final now = DateTime.now();
      return DateTime(now.year - 20, now.month, now.day);
    }
    try {
      return DateFormat('yyyy-MM-dd').parse(dateStr);
    } catch (_) {
      final now = DateTime.now();
      return DateTime(now.year - 20, now.month, now.day);
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final initial = _parseDate(_selectedDate);
    final firstDate = DateTime(now.year - 100);
    final lastDate = DateTime(now.year);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        DateTime tempPickedDate = initial;
        return Container(
          height: 275,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initial,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (DateTime newDate) {
                    tempPickedDate = newDate;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  final formatted = DateFormat('yyyy-MM-dd').format(tempPickedDate);
                  setState(() {
                    _selectedDate = formatted;
                  });
                  widget.onDateChanged(formatted);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = _selectedDate ?? S.current.chooseYourBirthday;

    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, color: Colors.blue),
            const SizedBox(width: 12),
            Text(
              displayDate,
              style: TextStyle(
                fontSize: 16,
                color: _selectedDate == null ? Colors.grey.shade500 : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
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
      key: buttonKey,
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

class SpinningImageWidget extends StatefulWidget {
  final String? imagePath;        // Đường dẫn ảnh local
  final String? imageUrl;         // URL ảnh network
  final Widget? child;            // Widget tùy chỉnh thay vì ảnh
  final double size;              // Kích thước spinner
  final Duration duration;        // Thời gian 1 vòng quay
  final bool clockwise;           // Chiều quay (true: thuận chiều kim đồng hồ)

  const SpinningImageWidget({
    super.key,
    this.imagePath,
    this.imageUrl,
    this.child,
    this.size = 50.0,
    this.duration = const Duration(seconds: 1),
    this.clockwise = true,
  });

  @override
  State<SpinningImageWidget> createState() => _SpinningImageWidgetState();
}

class _SpinningImageWidgetState extends State<SpinningImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.clockwise ? 1.0 : -1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // Bắt đầu animation và lặp vô hạn
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159, // 2π radians = 360 độ
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: _buildChild(),
          ),
        );
      },
    );
  }

  Widget _buildChild() {
    // Ưu tiên: child -> imagePath -> imageUrl -> default icons
    if (widget.child != null) {
      return widget.child!;
    } else if (widget.imagePath != null) {
      return Image.asset(
        widget.imagePath!,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
      );
    } else if (widget.imageUrl != null) {
      return Image.network(
        widget.imageUrl!,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.refresh,
            size: widget.size * 0.8,
            color: Colors.grey,
          );
        },
      );
    } else {
      // Default spinner icons
      return Icon(
        Icons.refresh,
        size: widget.size * 0.8,
        color: Colors.blue,
      );
    }
  }
}

class SpaceWidth extends StatelessWidget {
  final double? width;

  const SpaceWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return width != null
        ? SizedBox(
            width: width ?? 0,
          )
        : const Spacer();
  }
}

class SpaceHeight extends StatelessWidget {
  final double? height;

  const SpaceHeight(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return height != null
        ? SizedBox(
            width: height ?? 0,
          )
        : const Spacer();
  }
}
