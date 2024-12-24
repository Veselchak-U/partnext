import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

class PhotoItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final bool loading;

  const PhotoItem({
    required this.imageUrl,
    required this.onTap,
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: SizedBox(
          width: 64.w,
          height: 83.h,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: loading
                ? Center(child: const LoadingIndicator())
                : imageUrl.isEmpty
                    ? Center(
                        child: SvgPicture.asset(
                          Assets.icons.add.path,
                          width: 24.w,
                        ),
                      )
                    : SizedBox(
                        width: 64.w,
                        height: 83.h,
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
