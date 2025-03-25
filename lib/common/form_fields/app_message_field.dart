import 'dart:io';
import 'dart:math';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_shadows.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/focus_layout.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';

typedef MenuItem = ({RemoteFileType type, String icon, String label});

class AppMessageField extends StatefulWidget {
  final void Function(
    String message,
    List<File> attachments,
    RemoteFileType attachmentsType,
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
  final _menuList = <MenuItem>[
    (type: RemoteFileType.image, icon: Assets.icons.image.path, label: l10n?.image ?? ''),
    (type: RemoteFileType.document, icon: Assets.icons.document.path, label: l10n?.document ?? ''),
  ];
  final _textFieldFocusNode = FocusNode();

  String _text = '';
  List<File> _attachments = [];
  RemoteFileType _attachmentsType = RemoteFileType.document;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(_textFieldFocusNodeListener);
  }

  @override
  void dispose() {
    _textFieldFocusNode.removeListener(_textFieldFocusNodeListener);
    _textFieldFocusNode.dispose();

    _isMenuOpened.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    FocusLayoutData.of(context)?.isTapped;
    _hideMenu();

    super.didChangeDependencies();
  }

  void _onTextChanged(String value) {
    _text = value;
  }

  void _switchMenu() {
    _isMenuOpened.value = !_isMenuOpened.value;
  }

  void _hideMenu() {
    if (_isMenuOpened.value) {
      _isMenuOpened.value = false;
    }
  }

  void _onMenuSelected(MenuItem item) {
    _hideMenu();

    switch (item.type) {
      case RemoteFileType.image:
        _pickImages();
        break;
      case RemoteFileType.document:
        _pickDocuments();
        break;
    }
  }

  Future<void> _pickImages() async {
    final xFiles = await ImagePicker().pickMultiImage(
      requestFullMetadata: false,
    );
    if (xFiles.isEmpty) return;

    _attachmentsType = RemoteFileType.image;
    _sendFileMessage(xFiles);
  }

  Future<void> _pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: Config.attachmentAllowedFileExtensions,
    );
    if (result == null || result.xFiles.isEmpty) return;

    _attachmentsType = RemoteFileType.document;
    _sendFileMessage(result.xFiles);
  }

  Future<void> _sendFileMessage(List<XFile> xFiles) async {
    final maxSize = Config.attachmentMaxSize * 1024 * 1024;
    int total = 0;
    for (final xFile in xFiles) {
      final size = await xFile.length();
      total += size;
      if (total > maxSize) {
        if (context.mounted) {
          _onError(context.l10n.attachment_max_size(Config.attachmentMaxSize));
        }

        return;
      }
    }

    _attachments.addAll(
      xFiles.map((f) => File(f.path)),
    );
    _sendMessage();
  }

  Future<void> _sendMessage() async {
    _hideMenu();
    if (_text.isEmpty && _attachments.isEmpty) return;

    widget.onSend(_text, _attachments, _attachmentsType);
  }

  void _textFieldFocusNodeListener() {
    if (_textFieldFocusNode.hasFocus) _hideMenu();
  }

  void _onError(String message) {
    AppOverlays.showErrorBanner(message);
  }

  @override
  Widget build(BuildContext context) {
    final menuHeight = _menuList.length * 48.h + 16.h;
    final isLtr = context.locale.isLtr;

    return DeferredPointerHandler(
      child: Stack(
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
                  onPressed: _switchMenu,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextFormField(
                    focusNode: _textFieldFocusNode,
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
            top: -menuHeight - 8.h,
            left: isLtr ? 0 : null,
            right: isLtr ? null : 0,
            child: DeferPointer(
              child: ValueListenableBuilder<bool>(
                valueListenable: _isMenuOpened,
                builder: (context, isMenuOpened, child) {
                  return AnimatedSize(
                    duration: Duration(milliseconds: 150),
                    child: isMenuOpened ? child : const SizedBox.shrink(),
                  );
                },
                child: _Menu(
                  items: _menuList,
                  onTap: _onMenuSelected,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  final List<MenuItem> items;
  final Function(MenuItem) onTap;

  const _Menu({
    required this.items,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8).r,
        boxShadow: [AppShadows.container],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8).h,
      child: Column(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];

            return _MenuItem(
              item: item,
              onTap: () => onTap(item),
            );
          },
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onTap;

  const _MenuItem({
    required this.item,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 160.w,
          height: 48.h,
          child: Row(
            children: [
              SizedBox(width: 16.w),
              SvgPicture.asset(
                item.icon,
                height: 24.h,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  item.label,
                  style: AppTextStyles.s14w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ),
      ),
    );
  }
}
