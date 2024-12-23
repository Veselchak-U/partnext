import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/profile/presentation/profile_screen_vm.dart';
import 'package:partnext/features/profile/presentation/widgets/profile_actions_section.dart';
import 'package:partnext/features/profile/presentation/widgets/profile_user_section.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileScreenVm>();

    return MainSimpleLayout(
      titleText: context.l10n.profile,
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 8.w),
          child: IconButton(
            padding: EdgeInsets.all(12).h,
            icon: SvgPicture.asset(
              Assets.icons.camera.path,
              width: 24.h,
            ),
            onPressed: vm.changeUserAvatar,
          ),
        ),
      ],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                const ProfileUserSection(),
                SizedBox(height: 24.h),
                const ProfileActionsSection(),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: vm.loading,
            builder: (context, loading, _) {
              return LoadingContainerIndicator(loading: loading);
            },
          ),
        ],
      ),
    );
  }
}
