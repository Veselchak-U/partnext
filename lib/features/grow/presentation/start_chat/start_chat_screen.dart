import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/form_fields/app_message_field.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/grow/presentation/start_chat/start_chat_screen_vm.dart';
import 'package:partnext/features/grow/presentation/start_chat/widgets/start_chat_advice_block.dart';
import 'package:partnext/features/grow/presentation/start_chat/widgets/start_chat_photo_block.dart';
import 'package:provider/provider.dart';

class StartChatScreen extends StatelessWidget {
  const StartChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StartChatScreenVm>();
    final navBarRadius = 25.h;

    return MainLayout(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: vm.initializing,
            builder: (context, initializing, _) {
              if (initializing) return const SizedBox.shrink();

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16).w,
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.lets_talk_business,
                      style: AppTextStyles.s20w700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: StartChatPhotoBlock(
                        myImageUrl: vm.myImageUrl,
                        partnerImageUrl: vm.partner.questionnaire.photos.first,
                        partnerFullName: vm.partner.fullName,
                        partnerPosition: vm.partner.questionnaire.position ?? '',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const StartChatAdviceBlock(),
                    SizedBox(height: 16.h),
                    AppMessageField(
                      onSend: vm.onStartConversation,
                    ),
                    KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        final bottomPadding = isKeyboardVisible ? 16.h : 16.h + navBarRadius;

                        return SizedBox(height: bottomPadding);
                      },
                    ),
                  ],
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
