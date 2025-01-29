import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/focus_layout.dart';

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
  final _isMenuOpened = ValueNotifier<bool>(false);
  final _menuList = ['Photo', 'File'];

  String _text = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _isMenuOpened.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final unfocused = FocusLayoutData.of(context)?.isTapDown ?? false;
    if (unfocused) _hideMenu();

    super.didChangeDependencies();
  }

  void _onTextChanged(String value) {
    _text = value;
  }

  Future<void> _addAttachment() async {
    _switchMenu();
  }

  void _switchMenu() {
    _isMenuOpened.value = !_isMenuOpened.value;
  }

  void _hideMenu() {
    if (_isMenuOpened.value) {
      _isMenuOpened.value = false;
    }
  }

  Future<void> _sendMessage() async {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
        ),
        Positioned(
          top: -50.h,
          left: 0,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isMenuOpened,
            builder: (context, isMenuOpened, child) {
              return AnimatedSize(
                duration: Duration(milliseconds: 250),
                child: isMenuOpened
                    ? Column(
                        children: _menuList.map((e) => Text(e)).toList(),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }
}
