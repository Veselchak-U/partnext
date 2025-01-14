import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/utils/list_ext.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/plan_column.dart';
import 'package:provider/provider.dart';

class PlanGrid extends StatelessWidget {
  const PlanGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return Row(
      spacing: 24.r,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PlanColumn(
            isFirstColumn: true,
            items: vm.pricingPlans.getEvenElements<PricingPlanApiModel>(),
            onTap: vm.onSelectPlan,
          ),
        ),
        Expanded(
          child: PlanColumn(
            items: vm.pricingPlans.getOddElements<PricingPlanApiModel>(),
            onTap: vm.onSelectPlan,
          ),
        ),
      ],
    );
  }
}
