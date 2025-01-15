import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_scaffold.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';
import 'package:partnext/features/profile/presentation/upgrade/page/upgrade_first_page.dart';
import 'package:partnext/features/profile/presentation/upgrade/page/upgrade_second_page.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:provider/provider.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return AppScaffold(
      backgroundColor: AppColors.white,
      body: ValueListenableBuilder(
        valueListenable: vm.initializing,
        builder: (context, initializing, _) {
          if (initializing) return Center(child: const LoadingIndicator());

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: vm.pageController,
                      children: const [
                        UpgradeFirstPage(),
                        UpgradeSecondPage(),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
