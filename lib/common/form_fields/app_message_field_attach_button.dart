import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';

class AppMessageFieldAttachButton extends StatefulWidget {
  final bool? tappedBackground;

  const AppMessageFieldAttachButton({
    required this.tappedBackground,
    super.key,
  });

  @override
  State<AppMessageFieldAttachButton> createState() => _AppMessageFieldAttachButtonState();
}

class _AppMessageFieldAttachButtonState extends State<AppMessageFieldAttachButton> {
  final _isMenuOpened = ValueNotifier<bool>(false);

  final menuList = ['Photo', 'File'];

  @override
  void dispose() {
    _isMenuOpened.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppMessageFieldAttachButton oldWidget) {
    if (oldWidget.tappedBackground != widget.tappedBackground) {
      _hideMenu();
    }
    super.didUpdateWidget(oldWidget);
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            Assets.icons.paperClip32.path,
            height: 32.h,
          ),
          padding: EdgeInsets.zero,
          onPressed: _addAttachment,
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
                        children: menuList.map((e) => Text(e)).toList(),
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
