import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/widgets/navigation_item_widget.dart';
import 'package:partnext/features/profile/presentation/profile_screen_vm.dart';
import 'package:provider/provider.dart';

class ProfileActionsSection extends StatelessWidget {
  const ProfileActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileScreenVm>();

    return Container(
      height: 450.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25).r),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          NavigationItemWidget(
            iconAsset: Assets.icons.navShare.path,
            label: context.l10n.share,
            // onTap: () {},
          ),
          NavigationItemWidget(
            iconAsset: Assets.icons.navUpgrade.path,
            label: context.l10n.upgrade,
            // onTap: () {},
          ),
          NavigationItemWidget(
            iconAsset: Assets.icons.navFeedback.path,
            label: context.l10n.send_feedback,
            onTap: vm.sendFeedback,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
            child: Divider(),
          ),
          NavigationItemWidget(
            iconAsset: Assets.icons.navEdit.path,
            label: context.l10n.edit_profile,
            onTap: vm.editProfile,
          ),
          NavigationItemWidget(
            iconAsset: Assets.icons.navLogout.path,
            label: context.l10n.logout,
            onTap: vm.logOut,
          ),
        ],
      ),
    );
  }
}
