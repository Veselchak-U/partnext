import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/common/widgets/no_items_widget.dart';
import 'package:partnext/features/chat/presentation/chat_list_screen_vm.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChatListScreenVm>();

    return MainLayout(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: vm.chats,
            builder: (context, chats, _) {
              if (chats == null) return SizedBox.shrink();

              if (chats.isEmpty) {
                return NoItemsWidget(
                  message: context.l10n.no_chats,
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
                        SizedBox(height: 9.h),
                        Text(
                          context.l10n.chats,
                          style: AppTextStyles.s20w700,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 13.h),
                        ...List.generate(
                          chats.length,
                          (index) {
                            final item = chats[index];

                            return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SizedBox(
                                  height: 80.h,
                                  child: const Placeholder(),
                                ));
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
