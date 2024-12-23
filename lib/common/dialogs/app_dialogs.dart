import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppDialogs {
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String description,
    String? confirmLabel,
    bool showCancelButton = true,
    String? cancelLabel,
    bool? isDismissible,
  }) {
    return showAppDialog<bool>(
      context: context,
      isDismissible: isDismissible,
      title: title,
      description: description,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: showCancelButton,
            child: Padding(
              padding: EdgeInsets.only(right: 10.r),
              child: TextButton(
                onPressed: () => GoRouter.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  child: Text(
                    cancelLabel ?? context.l10n.cancel,
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => GoRouter.of(context).pop(true),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Text(
                confirmLabel ?? context.l10n.ok,
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> showAppDialog<T>({
    required BuildContext context,
    String? title,
    String? description,
    required Widget body,
    bool? isDismissible,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.primaryLight,
          child: Material(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(32, 24, 32, 16).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title?.isNotEmpty == true)
                    Text(
                      title ?? '',
                      style: AppTextStyles.s24w400,
                    ),
                  if (description?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10).r,
                      child: Text(
                        description ?? '',
                        style: AppTextStyles.s14w400,
                      ),
                    ),
                  SizedBox(height: 32.r),
                  body,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}