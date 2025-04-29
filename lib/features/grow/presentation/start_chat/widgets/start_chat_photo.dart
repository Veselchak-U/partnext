import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';

class StartChatPhoto extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const StartChatPhoto({
    required this.imageUrl,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final noPhoto = imageUrl.isEmpty;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(color: AppColors.white, width: 3),
        image: noPhoto
            ? null
            : DecorationImage(
                image: CachedNetworkImageProvider(
                  imageUrl,
                  errorListener: (error) {
                    debugPrint('!!! CachedNetworkImageProvider error: $error');
                  },
                ),
                fit: BoxFit.cover,
              ),
      ),
      child: noPhoto
          ? Center(
              child: Text(context.l10n.no_photo),
            )
          : null,
    );
  }
}
