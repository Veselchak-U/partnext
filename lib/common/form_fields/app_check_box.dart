import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppCheckBox extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final bool? checked;
  final void Function(bool?)? onChanged;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? color;

  const AppCheckBox({
    this.label,
    this.labelWidget,
    this.checked,
    this.onChanged,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;
    final foregroundColor = (color ?? AppColors.backgroundDark).withOpacity(enabled ? 1 : 0.5);

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Checkbox(
          value: checked,
          onChanged: onChanged,
          side: BorderSide(color: foregroundColor, width: 2),
        ),
        Expanded(
          child: labelWidget ??
              Text(
                label ?? '',
                style: AppTextStyles.s12w400.copyWith(
                  color: foregroundColor,
                ),
              ),
        ),
      ],
    );
  }
}
