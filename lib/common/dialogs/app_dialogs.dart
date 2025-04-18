import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';

class AppDialogs {
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String description,
    String? confirmLabel,
    bool showCancelButton = true,
    String? cancelLabel,
    bool? isDismissible,
    bool? isDanger,
  }) {
    final cancelColor = AppColors.primary;
    final confirmColor = isDanger == true ? AppColors.red : AppColors.primary;

    return showAppDialog<bool>(
      context: context,
      isDismissible: isDismissible,
      title: title,
      description: description,
      isDanger: isDanger,
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
                      color: cancelColor,
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
                  color: confirmColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showSecondaryDialog({
    required BuildContext context,
    required String title,
    required String description,
    String? confirmLabel,
    bool showCancelButton = true,
    String? cancelLabel,
    bool? isDismissible,
  }) {
    return showSecondaryAppDialog<bool>(
      context: context,
      isDismissible: isDismissible,
      title: title,
      description: description,
      body: Column(
        children: [
          CommonButton(
            label: confirmLabel ?? context.l10n.ok,
            onTap: () => GoRouter.of(context).pop(true),
          ),
          Visibility(
            visible: showCancelButton,
            child: Padding(
              padding: EdgeInsets.only(top: 8.r),
              child: CommonButton(
                type: CommonButtonType.bordered,
                label: cancelLabel ?? context.l10n.cancel,
                onTap: () => GoRouter.of(context).pop(false),
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
    bool? isDanger,
  }) {
    final theme = Theme.of(context);
    final titleStyle = isDanger == true ? AppTextStyles.s24w400.copyWith(color: AppColors.red) : AppTextStyles.s24w400;

    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
      builder: (context) {
        return Dialog(
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
                      style: titleStyle,
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

  static Future<T?> showSecondaryAppDialog<T>({
    required BuildContext context,
    String? title,
    String? description,
    required Widget body,
    bool? isDismissible,
    EdgeInsetsGeometry? padding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
      builder: (context) {
        return Dialog(
          child: Material(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(24, 39, 24, 32).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title?.isNotEmpty == true)
                    Text(
                      title ?? '',
                      style: AppTextStyles.s20w700,
                      textAlign: TextAlign.center,
                    ),
                  if (description?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 8).r,
                      child: Text(
                        description ?? '',
                        style: AppTextStyles.s14w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 24.r),
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
