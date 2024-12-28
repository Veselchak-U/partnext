import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';

class FeedbackAcceptedScreen extends StatefulWidget {
  final NavBarIndexProvider navBarIndexProvider;

  const FeedbackAcceptedScreen({
    required this.navBarIndexProvider,
    super.key,
  });

  @override
  State<FeedbackAcceptedScreen> createState() => _FeedbackAcceptedScreenState();
}

class _FeedbackAcceptedScreenState extends State<FeedbackAcceptedScreen> {
  final _loading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  void _goToHome() {
    _loading.value = true;

    context.goNamed(AppRoute.profile.name);
    Future.delayed(Duration(milliseconds: 50)).then(
      (_) => widget.navBarIndexProvider.reset(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32).w,
        child: Column(
          children: [
            const Spacer(),
            Assets.images.logo.image(width: 174.w),
            SizedBox(height: 39.h),
            Text(
              context.l10n.feedback_accepted,
              style: AppTextStyles.s24w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              context.l10n.thank_you_for_taking_time,
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
                  onTap: _goToHome,
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
