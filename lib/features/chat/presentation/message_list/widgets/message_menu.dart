import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/features/chat/presentation/message_list/widgets/message_menu_item.dart';

class MessageMenu extends StatelessWidget {
  final VoidCallback onReport;

  const MessageMenu({
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
            MessageMenuItem(
              label: context.l10n.report,
              iconAsset: Assets.icons.checkCircle.path,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10).r),
              onTap: () {
                context.pop();
                onReport.call();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: const Divider(),
            ),
            MessageMenuItem(
              label: context.l10n.cancel,
              iconAsset: Assets.icons.close.path,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10).r),
              color: AppColors.red,
              onTap: context.pop,
            ),
          ],
        ),
      ),
    );
  }
}
