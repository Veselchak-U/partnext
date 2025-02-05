import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
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
      title: Row(
        children: [
          Container(
            width: 32.h,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(vm.item.member.photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Text(
            vm.item.member.fullName,
            style: AppTextStyles.s18w500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: vm.openContextMenu,
        ),
      ],
      body: ValueListenableBuilder(
        valueListenable: vm.messages,
        builder: (context, messages, _) {
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async => vm.onRefresh(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16).w,
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
                                child: MessagesListItem(
                                  item,
                                  onTap: () => vm.onMessageTap(item),
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
