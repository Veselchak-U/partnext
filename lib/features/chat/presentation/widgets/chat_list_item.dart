import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatApiModel item;
  final VoidCallback onTap;

  const ChatListItem(
    this.item, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;
    final isLtr = context.locale.isLtr;
    final unreadCount = (item.unreadMessageCount) < 10
        ? '${item.unreadMessageCount}'
        : isLtr
            ? '9+'
            : '+9';
    final messageTitleStyle = AppTextStyles.s12w600.copyWith(height: 15 / 12);
    final messageDescStyle = AppTextStyles.s12w400.copyWith(height: 15 / 12);

    final photoUrl = item.member.photoUrl;

    return Stack(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Container(
              height: 84.h,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.all(16).r,
              child: Row(
                children: [
                  Container(
                    width: 48.h,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10).r,
                      image: photoUrl == null
                          ? null
                          : DecorationImage(
                              image: CachedNetworkImageProvider(
                                photoUrl,
                                errorListener: (error) {
                                  debugPrint('!!! CachedNetworkImageProvider error: $error');
                                },
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: photoUrl == null ? Icon(Icons.person) : null,
                  ),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.member.fullName,
                          style: messageTitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: item.lastMessageCreator,
                                style: messageDescStyle.copyWith(color: AppColors.primarySecond),
                              ),
                              TextSpan(
                                text: item.lastMessageDescription,
                                style: messageDescStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: 7.h,
          end: 8.w,
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            child: (item.unreadMessageCount) == 0
                ? const SizedBox.shrink()
                : IgnorePointer(
                    child: Container(
                      width: 24.h,
                      height: 24.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundBright,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        unreadCount,
                        style: AppTextStyles.s14w700.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
