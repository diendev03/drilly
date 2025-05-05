import 'package:flutter/material.dart';

class RotatingWidget extends StatefulWidget {
  final Widget child;

  const RotatingWidget({super.key, required this.child});

  @override
  RotatingWidgetState createState() => RotatingWidgetState();
}

class RotatingWidgetState extends State<RotatingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: -0.175, end: 0.175).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Lặp lại animation vô hạn
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
