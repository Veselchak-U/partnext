import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/features/chat/presentation/message_list/widgets/chat_menu_item.dart';

class ChatMenu extends StatelessWidget {
  final VoidCallback onUnmatch;
  final VoidCallback onReport;

  const ChatMenu({
    required this.onUnmatch,
    required this.onReport,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10).r;

    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 64.h, 32.w, 64.h),
      child: Material(
        color: AppColors.white,
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatMenuItem(
              label: context.l10n.unmatch,
              iconAsset: Assets.icons.heartMinus.path,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10).r),
              color: AppColors.red,
              onTap: () {
                context.pop();
                onUnmatch.call();
              },
            ),
            ChatMenuItem(
              label: context.l10n.report,
              iconAsset: Assets.icons.report.path,
              color: AppColors.red,
              onTap: () {
                context.pop();
                onReport.call();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: const Divider(),
            ),
            ChatMenuItem(
              label: context.l10n.cancel,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10).r),
              color: AppColors.primary,
              onTap: context.pop,
            ),
          ],
        ),
      ),
    );
  }
}
