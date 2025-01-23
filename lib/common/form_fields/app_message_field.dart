import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

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

  Future<void> _addAttachment() async {}

  Future<void> _sendMessage() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(48, 48.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: Row(
        children: [
          IconButton(
            icon: SvgPicture.asset(
              Assets.icons.paperClip32.path,
              height: 32.h,
            ),
            padding: EdgeInsets.zero,
            onPressed: _addAttachment,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                hintText: 'Write a message...',
                hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.gray),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          IconButton(
            icon: SvgPicture.asset(
              Assets.icons.send.path,
              height: 24.h,
            ),
            padding: EdgeInsets.zero,
            onPressed: _sendMessage,
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
