import 'package:flutter/material.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

class PageLoaderWidget extends StatelessWidget {
  final bool loading;

  const PageLoaderWidget({
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingIndicator(),
          )
        : const SizedBox.shrink();
  }
}
