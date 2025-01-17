import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/grow/presentation/grow_screen_vm.dart';
import 'package:partnext/features/grow/presentation/widgets/no_partners_widget.dart';
import 'package:partnext/features/partner/presentation/partner_item/partner_item_widget.dart';
import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GrowScreenVm>();

    return MainLayout(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: vm.partners,
            builder: (context, partners, _) {
              if (partners == null) return SizedBox.shrink();

              if (partners.isEmpty) {
                return NoPartnersWidget(
                  onRefresh: () async => vm.onRefresh(),
                );
              }

              return RefreshIndicator(
                onRefresh: () async => vm.onRefresh(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 32).w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      children: [
                        Text(
                          context.l10n.partnext_grow,
                          style: AppTextStyles.s20w700,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          context.l10n.your_growth_can_accelerate,
                          style: AppTextStyles.s14w400,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ...List.generate(
                          partners.length,
                          (index) {
                            final item = partners[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: PartnerItemWidget(
                                item,
                                onTap: () => vm.onOpenPartnerDetails(item),
                                onApprove: () => vm.onApprove(item),
                                onReject: () => vm.onReject(item),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
