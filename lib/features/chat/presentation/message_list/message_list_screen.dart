import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
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
import 'package:partnext/features/chat/presentation/message_list/widgets/page_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MessageListScreenVm>();

    return ValueListenableBuilder(
      valueListenable: vm.initialized,
      builder: (context, initialized, _) {
        if (!initialized) {
          return MainLayout(
            body: ValueListenableBuilder(
              valueListenable: vm.loading,
              builder: (context, loading, _) {
                return LoadingContainerIndicator(loading: loading);
              },
            ),
          );
        }

        final chat = vm.chat.value;
        if (chat == null) return SizedBox.shrink();

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
                    image: CachedNetworkImageProvider(
                      chat.member.photoUrl,
                      errorListener: (error) {
                        debugPrint('!!! CachedNetworkImageProvider error: $error');
                      },
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                chat.member.fullName,
                style: AppTextStyles.s18w500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: vm.openChatMenu,
            ),
          ],
          body: ValueListenableBuilder(
            valueListenable: vm.messages,
            builder: (context, messages, _) {
              final messagesLength = messages?.length ?? 0;

              return Stack(
                children: [
                  CustomMaterialIndicator(
                    trigger: IndicatorTrigger.bothEdges,
                    onRefresh: () async => vm.onRefresh(),
                    child: ListView.separated(
                      controller: vm.autoScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                      itemCount: messagesLength + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ValueListenableBuilder(
                            valueListenable: vm.previousPageLoading,
                            builder: (context, previousPageLoading, _) {
                              return PageLoaderWidget(
                                onInit: vm.getPreviousPage,
                                loading: previousPageLoading,
                              );
                            },
                          );
                        }

                        if (index == messagesLength + 1) {
                          return ValueListenableBuilder(
                            valueListenable: vm.nextPageLoading,
                            builder: (context, nextPageLoading, _) {
                              return PageLoaderWidget(
                                onInit: vm.getNextPage,
                                loading: nextPageLoading,
                              );
                            },
                          );
                        }

                        final actualIndex = index - 1;
                        final item = messages?[actualIndex];
                        if (item == null) return SizedBox.shrink();

                        return AutoScrollTag(
                          key: ValueKey(actualIndex),
                          index: actualIndex,
                          controller: vm.autoScrollController,
                          child: ValueListenableBuilder(
                            valueListenable: vm.unreadMessageIndex,
                            builder: (context, unreadMessageIndex, _) {
                              return MessagesListItem(
                                item,
                                isUnread: item.isUnread(unreadMessageIndex),
                                onTap: () => vm.onMessageTap(item),
                                onLongPress: () => vm.openMessageMenu(item),
                                onVisible: () => vm.onVisible(item),
                              );
                            },
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
      },
    );
  }
}
