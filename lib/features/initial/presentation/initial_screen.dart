import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';
import 'package:partnext/features/initial/presentation/initial_screen_vm.dart';
import 'package:partnext/features/welcome/presentation/widgets/welcome_body.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<InitialScreenVm>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const WelcomeBody(),
          SafeArea(
            child: SizedBox(
              height: max(145, 145.h),
              child: ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return switch (loading) {
                    true => const Center(child: LoadingIndicator()),
                    false => const Center(child: SizedBox.shrink()),
                  };
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
