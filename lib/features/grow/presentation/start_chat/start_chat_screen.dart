import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/grow/presentation/start_chat/start_chat_screen_vm.dart';
import 'package:provider/provider.dart';

class StartChatScreen extends StatelessWidget {
  const StartChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StartChatScreenVm>();

    return MainLayout(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Text(
                  context.l10n.lets_talk_business,
                  style: AppTextStyles.s20w700,
                  textAlign: TextAlign.center,
                ),
              ],
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
