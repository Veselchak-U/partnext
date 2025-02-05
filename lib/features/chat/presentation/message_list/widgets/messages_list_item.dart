import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/utils/date_time_ext.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

class MessagesListItem extends StatelessWidget {
  final MessageApiModel item;
  final VoidCallback onTap;

  const MessagesListItem(
    this.item, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMyMessage = item.creator.isCurrentUser ?? false;
    final crossAxisAlignment = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Row(
      children: [
        if (isMyMessage) SizedBox(width: 64.w),
        Expanded(
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isMyMessage ? AppColors.backgroundMessage : AppColors.white,
                  borderRadius: BorderRadius.circular(8).r,
                ),
                // padding: EdgeInsets.all(17).r,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    SizedBox(height: 16.h),
                    if (item.isImage)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8).h,
                        child: CachedNetworkImage(
                          imageUrl: item.attachment?.url ?? '',
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16).w,
                      child: Text(
                        item.description,
                        style: AppTextStyles.s12w400.copyWith(color: AppColors.black),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              SizedBox(height: 9.h),
              Text(
                item.createdAt.timeShort(),
                style: AppTextStyles.s12w400.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
        if (!isMyMessage) SizedBox(width: 64.w),
      ],
    );
  }
}
