import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/form_fields/app_text_field.dart';
import 'package:partnext/common/utils/input_validators.dart';

class AppDateField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final DateTime? initialDate;
  final ValidatorFunction? validator;
  final Function(DateTime?)? onChanged;
  final bool isForBirth;
  final bool filled;
  final bool enabled;
  final DateTime? minDate;
  final DateTime? maxDate;

  const AppDateField({
    required this.label,
    this.controller,
    this.initialDate,
    this.validator,
    this.onChanged,
    this.isForBirth = false,
    this.filled = false,
    this.enabled = true,
    this.minDate,
    this.maxDate,
    super.key,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  late final TextEditingController controller;
  late final bool isInnerController;
  final _showClearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    isInnerController = widget.controller == null;

    _setInitialDate();
  }

  @override
  void dispose() {
    _showClearButton.dispose();
    if (isInnerController) controller.dispose();
    super.dispose();
  }

  void _setInitialDate() {
    final initialDate = widget.initialDate;
    if (initialDate != null) {
      controller.text = DateFormat("dd.MM.yyyy").format(initialDate);
    }
    if (controller.text.isNotEmpty && widget.enabled) {
      _showClearButton.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        AppTextField(
          label: widget.label,
          controller: controller,
          validator: widget.validator,
          textInputAction: TextInputAction.unspecified,
          suffixIconPath: Assets.icons.calendar.path,
          readOnly: true,
          enabled: widget.enabled,
          filled: widget.filled,
          onTap: !widget.enabled
              ? null
              : () => _pickDate(
                    context,
                    controller,
                    isForBirth: widget.isForBirth,
                    minDate: widget.minDate,
                    maxDate: widget.maxDate,
                  ),
        ),
        ValueListenableBuilder(
          valueListenable: _showClearButton,
          builder: (context, show, _) {
            if (!show) return const SizedBox.shrink();

            return Padding(
              padding: EdgeInsetsDirectional.only(top: max(32.0, 32.h), end: 48.w),
              child: IconButton(
                icon: const Icon(Icons.cancel, color: AppColors.gray),
                onPressed: () => _clear(controller),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController textController, {
    required bool isForBirth,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    const duration18Year = Duration(days: (365 * 18) + 4 + 1);
    const duration100Year = Duration(days: (365 * 100) + 25);

    final firstDate = minDate ?? DateTime.now().subtract(duration100Year);
    final lastDate =
        maxDate ?? (isForBirth ? DateTime.now().subtract(duration18Year) : DateTime.now().add(duration100Year));

    final selectedDate = DateFormat("dd.MM.yyyy").tryParse(textController.text);
    final initialDate = selectedDate ?? (isForBirth ? DateTime.now().subtract(duration18Year) : lastDate);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      textController.text = DateFormat("dd.MM.yyyy").format(picked);
      widget.onChanged?.call(picked);
      _showClearButton.value = true;
    }
  }

  void _clear(TextEditingController textController) {
    textController.text = '';
    widget.onChanged?.call(null);
    _showClearButton.value = false;
  }
}
