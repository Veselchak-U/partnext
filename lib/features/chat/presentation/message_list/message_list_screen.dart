import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/common/widgets/no_items_widget.dart';
import 'package:partnext/features/chat/presentation/message_list/message_list_screen_vm.dart';
import 'package:partnext/features/chat/presentation/message_list/widgets/messages_list_item.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MessageListScreenVm>();

    return MainLayout(
      body: ValueListenableBuilder(
        valueListenable: vm.messages,
        builder: (context, messages, _) {
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async => vm.onRefresh(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 32).w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        if (messages != null)
                          ...List.generate(
                            messages.length,
                            (index) {
                              final item = messages[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SizedBox(
                                  height: 80.h,
                                  child: MessagesListItem(
                                    item,
                                    onTap: () => vm.onMessageTap(item),
                                  ),
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              ),
              if (messages?.isEmpty == true)
                NoItemsWidget(
                  message: context.l10n.no_messages,
                  onRefresh: () async => vm.onRefresh(),
                ),
              ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return LoadingContainerIndicator(loading: loading);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
