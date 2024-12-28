import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';

class FeedbackAcceptedScreen extends StatefulWidget {
  const FeedbackAcceptedScreen({super.key});

  @override
  State<FeedbackAcceptedScreen> createState() => _FeedbackAcceptedScreenState();
}

class _FeedbackAcceptedScreenState extends State<FeedbackAcceptedScreen> {
  final _loading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                ValueListenableBuilder(
                  valueListenable: _loading,
                  builder: (context, loading, _) {
                    return LoadingContainerIndicator(loading: loading);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
