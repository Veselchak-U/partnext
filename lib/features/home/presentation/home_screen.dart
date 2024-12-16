import 'package:flutter/material.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:partnext/features/partner/presentation/widgets/no_recommendations_widget.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return MainLayout(
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
                // controller: vm.swipableController,
                itemCount: recommendations.length,
                builder: (context, properties) {
                  final item = recommendations[properties.index];

                  return RecommendationItemWidget(item);
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
