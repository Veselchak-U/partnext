import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/profile/presentation/profile_screen_vm.dart';
import 'package:provider/provider.dart';

class ProfileUserSection extends StatelessWidget {
  const ProfileUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileScreenVm>();

    return ValueListenableBuilder(
      valueListenable: vm.user,
      builder: (context, user, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: user == null
              ? SizedBox(height: 264.r)
              : Column(
                  children: [
                    SizedBox(
                      width: 184.r,
                      height: 196.r,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 0,
                            child: CircleAvatar(
                              radius: 92.r,
                              backgroundImage: CachedNetworkImageProvider(
                                user.imageUrl ?? '',
                                errorListener: (error) {
                                  debugPrint('!!! CachedNetworkImageProvider error: $error');
                                },
                              ),
                            ),
                          ),
                          if (user.isPremium)
                            Container(
                              width: 56.r,
                              height: 24.r,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(4).r,
                              ),
                              child: Center(
                                child: Text(
                                  'PRO',
                                  style: AppTextStyles.s12w700.copyWith(color: AppColors.white),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      user.fullName,
                      style: AppTextStyles.s28w700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      user.position ?? '',
                      style: AppTextStyles.s14w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
