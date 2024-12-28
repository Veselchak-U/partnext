import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:provider/provider.dart';

class UpgradeButtonBlock extends StatelessWidget {
  const UpgradeButtonBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24).r,
          child: ValueListenableBuilder(
            valueListenable: vm.loading,
            builder: (context, loading, _) {
              return CommonButton(
                label: context.l10n.continue_label,
                iconPath: Assets.icons.send.path,
                onTap: vm.onContinue,
                loading: loading,
              );
            },
          ),

          // ValueListenableBuilder(
          //   valueListenable: vm.isLastPage,
          //   builder: (context, isLastPage, _) {
          //     return ValueListenableBuilder(
          //       valueListenable: vm.loading,
          //       builder: (context, loading, _) {
          //         return Column(
          //           children: [
          //             AnimatedSwitcher(
          //               duration: const Duration(milliseconds: 150),
          //               child: isLastPage
          //                   ? CommonButton(
          //                       key: ValueKey(true),
          //                       label: vm.isEditMode ? context.l10n.save : context.l10n.finish_registration,
          //                       iconPath: Assets.icons.send.path,
          //                       onTap: vm.onNextPage,
          //                       loading: loading,
          //                     )
          //                   : CommonButton(
          //                       key: ValueKey(false),
          //                       label: context.l10n.next,
          //                       iconPath: Assets.icons.send.path,
          //                       onTap: vm.onNextPage,
          //                       loading: loading,
          //                     ),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
