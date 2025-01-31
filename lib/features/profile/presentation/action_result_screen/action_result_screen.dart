import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen_params.dart';

class ActionResultScreen extends StatefulWidget {
  final NavBarIndexProvider navBarIndexProvider;
  final ActionResultScreenParams params;

  const ActionResultScreen({
    required this.navBarIndexProvider,
    required this.params,
    super.key,
  });

  @override
  State<ActionResultScreen> createState() => _ActionResultScreenState();
}

class _ActionResultScreenState extends State<ActionResultScreen> {
  final _loading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  void _goHomeTab() {
    _loading.value = true;

    context.goNamed(AppRoute.profile.name);
    Future.delayed(Duration(milliseconds: 50)).then(
      (_) => widget.navBarIndexProvider.reset(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleLayout(
      sysAppBarBackgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32).w,
        child: Column(
          children: [
            const Spacer(),
            Assets.images.logo.image(width: 174.w),
            SizedBox(height: 39.h),
            Text(
              widget.params.title,
              style: AppTextStyles.s24w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              widget.params.description,
              style: AppTextStyles.s14w400,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: _loading,
              builder: (context, loading, _) {
                return CommonButton(
                  label: context.l10n.continue_browsing,
                  iconPath: Assets.icons.send.path,
                  onTap: _goHomeTab,
                  loading: loading,
                );
              },
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
