import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppCheckBox extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final bool? checked;
  final void Function(bool?)? onChanged;
  final Color? color;

  const AppCheckBox({
    this.label,
    this.labelWidget,
    this.checked,
    this.onChanged,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;
    final borderColor = color ?? AppColors.backgroundDark.withValues(alpha: enabled ? 1 : 0.5);
    final foregroundColor = color ?? AppColors.primary.withValues(alpha: enabled ? 1 : 0.5);

    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: onChanged,
          side: BorderSide(color: borderColor, width: 2),
        ),
        Expanded(
          child: labelWidget ??
              Text(
                label ?? '',
                style: AppTextStyles.s14w400.copyWith(color: foregroundColor),
              ),
        ),
      ],
    );
  }
}
