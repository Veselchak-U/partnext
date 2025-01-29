import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/grow/presentation/partner_details/partner_details_screen_vm.dart';
import 'package:partnext/features/partner/presentation/recommendation_item_widget.dart';
import 'package:provider/provider.dart';

class PartnerDetailsScreen extends StatelessWidget {
  const PartnerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PartnerDetailsScreenVm>();

    return MainLayout(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: RecommendationItemWidget(
              padding: const EdgeInsets.only(top: 16).h,
              vm.partner,
              onOpenLink: vm.openLink,
              onApprove: vm.onApprove,
              onReject: vm.onReject,
              withHeroEffect: true,
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
