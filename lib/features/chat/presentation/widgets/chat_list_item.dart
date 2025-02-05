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
    final unreadCount = item.unreadCount < 10
        ? '${item.unreadCount}'
        : isLtr
            ? '9+'
            : '+9';

    return Stack(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.all(16).r,
              child: Row(
                children: [
                  Container(
                    width: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10).r,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(item.member.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.member.fullName,
                          style: AppTextStyles.s12w600.copyWith(height: 15 / 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.lastMessageDescription,
                          style: AppTextStyles.s12w400.copyWith(height: 15 / 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
            child: item.unreadCount == 0
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
