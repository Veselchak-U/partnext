import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/features/grow/presentation/start_chat/widgets/start_chat_photo.dart';

class StartChatPhotoBlock extends StatelessWidget {
  final String myImageUrl;
  final String partnerImageUrl;
  final String partnerFullName;
  final String partnerPosition;

  const StartChatPhotoBlock({
    required this.myImageUrl,
    required this.partnerImageUrl,
    required this.partnerFullName,
    required this.partnerPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16).w,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final photoWidth = constraints.maxWidth * 0.6;
          final photoHeight = min(255.h, constraints.maxHeight);

          return Stack(
            children: [
              Positioned(
                top: 35.h,
                left: 27.w,
                child: Image.asset(Assets.images.logoWhite.path, height: 88.h),
              ),
              Positioned(
                bottom: 19.h,
                right: 15.w,
                child: SvgPicture.asset(Assets.icons.approve.path, height: 92.h),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: StartChatPhoto(
                  imageUrl: myImageUrl,
                  width: photoWidth,
                  height: photoHeight,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: StartChatPhoto(
                  imageUrl: partnerImageUrl,
                  width: photoWidth,
                  height: photoHeight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
