import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/plan_card.dart';
import 'package:provider/provider.dart';

class PlanColumn extends StatelessWidget {
  final List<PricingPlanApiModel> items;
  final Function(PricingPlanApiModel) onTap;
  final bool isFirstColumn;

  const PlanColumn({
    required this.items,
    required this.onTap,
    this.isFirstColumn = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return Column(
      spacing: 24.r,
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          final height = _getHeight(isFirstColumn, index);
          final borderColor = _getBorderColor(isFirstColumn, index);
          final backgroundImage = _getBackgroundImage(isFirstColumn, index);

          return ValueListenableBuilder(
            valueListenable: vm.selectedPlan,
            builder: (context, selectedPlan, _) {
              return PlanCard(
                item: item,
                isSelected: item == selectedPlan,
                height: height,
                borderColor: borderColor,
                backgroundImage: backgroundImage,
                onTap: () => onTap(item),
              );
            },
          );
        },
      ),
    );
  }

  Color _getBorderColor(bool isFirstColumn, int index) {
    return isFirstColumn
        ? index % 2 == 0
            ? AppColors.border0
            : AppColors.border2
        : index % 2 == 0
            ? AppColors.border1
            : AppColors.border3;
  }

  ImageProvider _getBackgroundImage(bool isFirstColumn, int index) {
    return isFirstColumn
        ? index % 2 == 0
            ? Assets.images.mask0.provider()
            : Assets.images.mask2.provider()
        : index % 2 == 0
            ? Assets.images.mask1.provider()
            : Assets.images.mask3.provider();
  }

  double _getHeight(bool isFirstColumn, int index) {
    return isFirstColumn
        ? index % 2 == 0
            ? 176.h
            : 128.h
        : index % 2 == 0
            ? 128.h
            : 176.h;
  }
}
