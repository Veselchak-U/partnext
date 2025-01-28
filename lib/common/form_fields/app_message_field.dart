import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
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
  String _text = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTextChanged(String value) {
    _text = value;
  }

  Future<void> _addAttachment() async {}

  Future<void> _sendMessage() async {}

  final menuList = ['Photo', 'File'];

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
          PopupMenuButton<String>(
            elevation: 1,
            // position: PopupMenuPosition.over,
            offset: Offset(0, -115.h),
            itemBuilder: (context) => menuList
                .map<PopupMenuItem<String>>(
                  (e) => PopupMenuItem<String>(value: e, child: Text(e)),
                )
                .toList(),
            // padding: const EdgeInsets.all(0),
            child: SvgPicture.asset(
              Assets.icons.paperClip32.path,
              height: 32.h,
            ),
          ),
          // IconButton(
          //   icon: SvgPicture.asset(
          //     Assets.icons.paperClip32.path,
          //     height: 32.h,
          //   ),
          //   padding: EdgeInsets.zero,
          //   onPressed: _addAttachment,
          // ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                hintText: context.l10n.write_message,
                hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.gray),
              ),
              onChanged: _onTextChanged,
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
