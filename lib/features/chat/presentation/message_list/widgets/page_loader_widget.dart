import 'package:flutter/material.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

class PageLoaderWidget extends StatefulWidget {
  final VoidCallback onInit;
  final bool loading;

  const PageLoaderWidget({
    required this.onInit,
    required this.loading,
    super.key,
  });

  @override
  State<PageLoaderWidget> createState() => _PageLoaderWidgetState();
}

class _PageLoaderWidgetState extends State<PageLoaderWidget> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = widget.loading;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.onInit(),
    );
  }

  @override
  void didUpdateWidget(PageLoaderWidget oldWidget) {
    if (widget.loading != oldWidget.loading) {
      _setLoading(widget.loading);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingIndicator(),
          )
        : const SizedBox.shrink();
  }
}
