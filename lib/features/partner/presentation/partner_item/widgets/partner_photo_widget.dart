import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PartnerPhotoWidget extends StatefulWidget {
  final List<String> urls;

  const PartnerPhotoWidget(
    this.urls, {
    super.key,
  });

  @override
  State<PartnerPhotoWidget> createState() => _PartnerPhotoWidgetState();
}

class _PartnerPhotoWidgetState extends State<PartnerPhotoWidget> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _precacheImages(),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _precacheImages() {
    final count = widget.urls.length;
    if (count < 2) return;

    Future.wait(
      List.generate(
        count - 1,
        (index) => precacheImage(
          CachedNetworkImageProvider(
            widget.urls[index + 1],
            errorListener: (error) {
              debugPrint('!!! CachedNetworkImageProvider error: $error');
            },
          ),
          context,
        ),
      ),
    );
  }

  void _onPressLeft() {
    final isLtr = context.locale.isLtr;
    if (isLtr) {
      _goPreviousPage();
    } else {
      _goNextPage();
    }
  }

  void _onPressRight() {
    final isLtr = context.locale.isLtr;
    if (isLtr) {
      _goNextPage();
    } else {
      _goPreviousPage();
    }
  }

  void _goNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  void _goPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.urls.isEmpty) return const SizedBox.shrink();

    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: SizedBox(
        width: 112.r,
        height: 112.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: List.generate(
                widget.urls.length,
                (index) => ClipRRect(
                  borderRadius: borderRadius,
                  child: CachedNetworkImage(
                    imageUrl: widget.urls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    iconSize: 24.r,
                    alignment: Alignment.centerLeft,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color?>(Colors.white.withValues(alpha: 0.4)),
                      foregroundColor: const WidgetStatePropertyAll<Color?>(AppColors.primary),
                      fixedSize: WidgetStatePropertyAll<Size?>(Size.square(42.r)),
                    ),
                    onPressed: _onPressLeft,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    iconSize: 24.r,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color?>(Colors.white.withValues(alpha: 0.4)),
                      foregroundColor: const WidgetStatePropertyAll<Color?>(AppColors.primary),
                      fixedSize: WidgetStatePropertyAll<Size?>(Size.square(42.r)),
                    ),
                    onPressed: _onPressRight,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 14.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32).w,
                child: SmoothPageIndicator(
                  controller: pageController,
                  textDirection: context.locale.isRtl ? TextDirection.rtl : TextDirection.ltr,
                  count: widget.urls.length,
                  effect: SlideEffect(
                    dotWidth: 40.w,
                    dotHeight: 4.h,
                    spacing: 5.w,
                    activeDotColor: AppColors.primary,
                    dotColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
