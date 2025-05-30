import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/utils/date_time_ext.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessagesListItem extends StatelessWidget {
  final MessageApiModel message;
  final bool isUnread;
  final VoidCallback onTap;
  final VoidCallback onVisible;

  const MessagesListItem(
    this.message, {
    required this.isUnread,
    required this.onTap,
    required this.onVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMyMessage = message.creator.isCurrentUser ?? false;
    final crossAxisAlignment = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final borderRadius = BorderRadius.circular(8).r;
    final textStyle = isUnread
        ? AppTextStyles.s12w600.copyWith(color: AppColors.black)
        : AppTextStyles.s12w400.copyWith(color: AppColors.black);

    return VisibilityDetector(
      key: ValueKey(message.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) onVisible.call();
      },
      child: Row(
        children: [
          if (isMyMessage) SizedBox(width: 64.w),
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Material(
                  color: isMyMessage ? AppColors.backgroundMessage : AppColors.white,
                  borderRadius: borderRadius,
                  child: InkWell(
                    borderRadius: borderRadius,
                    onTap: onTap,
                    child: Column(
                      crossAxisAlignment: crossAxisAlignment,
                      children: [
                        SizedBox(height: 16.h),
                        if (message.isImage)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8).h,
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 150.h,
                              child: CachedNetworkImage(
                                imageUrl: message.attachment?.url ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16).w,
                          child: Text(
                            message.description,
                            style: textStyle,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  message.createdAt.timeShort(),
                  style: AppTextStyles.s12w400.copyWith(color: AppColors.gray),
                ),
              ],
            ),
          ),
          if (!isMyMessage) SizedBox(width: 64.w),
        ],
      ),
    );
  }
}
