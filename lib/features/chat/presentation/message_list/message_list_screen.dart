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
import 'package:scroll_to_index/scroll_to_index.dart';

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
                image: CachedNetworkImageProvider(vm.chat.member.photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Text(
            vm.chat.member.fullName,
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
                child: ListView.separated(
                  controller: vm.autoScrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                  itemCount: messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = messages?[index];
                    if (item == null) return SizedBox.shrink();

                    return AutoScrollTag(
                      key: ValueKey(index),
                      index: index,
                      controller: vm.autoScrollController,
                      child: MessagesListItem(
                        item,
                        onTap: () => vm.onMessageTap(item),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
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
