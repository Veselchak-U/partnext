import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/grow/presentation/grow_screen_vm.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:provider/provider.dart';

class PartnerDetailsScreen extends StatelessWidget {
  final PartnerApiModel item;

  const PartnerDetailsScreen({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GrowScreenVm>();

    return MainLayout(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 32).w,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                children: [],
              ),
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
