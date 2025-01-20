import 'dart:io';

import 'package:flutter/material.dart';

class AppMessageField extends StatefulWidget {
  final void Function(
    String message,
    List<File> attachments,
  ) onSend;

  const AppMessageField({
    required this.onSend,
    super.key,
  });

  @override
  State<AppMessageField> createState() => _AppMessageFieldState();
}

class _AppMessageFieldState extends State<AppMessageField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
