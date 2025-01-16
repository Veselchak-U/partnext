import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

class LoadingContainerIndicator extends StatelessWidget {
  final bool loading;

  const LoadingContainerIndicator({
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: loading
          ? Container(
              color: AppColors.background.withValues(alpha: 0.6),
              child: const Center(
                child: LoadingIndicator(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
