import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class PartnershipDescriptionOverlay {
  final BuildContext context;
  final String text;
  final VoidCallback onTap;

  PartnershipDescriptionOverlay(
    this.context, {
    required this.text,
    required this.onTap,
  });

  OverlayEntry? build() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final hPadding = 52.h;
    final offset = renderBox?.localToGlobal(Offset(0, hPadding));
    if (offset == null) return null;

    return OverlayEntry(
      builder: (context) {
        final wPadding = 32.r;
        final width = MediaQuery.of(context).size.width - wPadding * 2;

        return Positioned.directional(
          textDirection: context.locale.isLtr ? TextDirection.ltr : TextDirection.rtl,
          width: width,
          top: offset.dy,
          end: offset.dx,
          child: GestureDetector(
            onTap: onTap,
            child: Material(
              borderRadius: BorderRadius.circular(8).r,
              color: AppColors.white,
              shadowColor: AppColors.shadow,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16).r,
                child: Text(
                  text,
                  style: AppTextStyles.s10w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
