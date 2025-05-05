// Tạo component Home stateless
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {

  const MessageScreen({
    super.key,});

  @override
  Widget build(BuildContext context) {
    // Xây dựng giao diện dựa trên state
    return const Scaffold(
        body: Text("MessageScreen")
    );
  }
}