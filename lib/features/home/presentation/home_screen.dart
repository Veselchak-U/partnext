import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:partnext/features/partner/presentation/recommendation_item_widget.dart';
import 'package:partnext/features/partner/presentation/widgets/no_recommendations_widget.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_overlay.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    // Properties from MainLayout
    final appBarBorderRadius = const Radius.circular(16).r;
    final toolbarHeight = max(kToolbarHeight, kToolbarHeight.h);
    final topBodyPadding = toolbarHeight - appBarBorderRadius.y;

    return MainLayout(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: vm.recommendations,
            builder: (context, recommendations, _) {
              if (recommendations == null) return SizedBox.shrink();

              if (recommendations.isEmpty) {
                return NoRecommendationsWidget(
                  isTooManySwipes: vm.isTooManySwipes,
                  onRefresh: () async => vm.onRefresh(),
                );
              }

              return SwipableStack(
                allowVerticalSwipe: false,
                swipeAnchor: SwipeAnchor.bottom,
                controller: vm.swipableController,
                itemCount: recommendations.length,
                builder: (context, properties) {
                  final item = recommendations[properties.index];

                  return RecommendationItemWidget(
                    item,
                    onOpenLink: vm.onOpenLink,
                    onApprove: vm.onApprove,
                    onReject: vm.onReject,
                    padding: EdgeInsets.only(top: topBodyPadding),
                  );
                },
                overlayBuilder: (context, swipeProperty) {
                  final opacity = min(swipeProperty.swipeProgress, 1.0);
                  final isRight = swipeProperty.direction == SwipeDirection.right;

                  return Opacity(
                    opacity: opacity,
                    child: RecommendationOverlay(isRight),
                  );
                },
                onSwipeCompleted: vm.onSwipeCompleted,
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
