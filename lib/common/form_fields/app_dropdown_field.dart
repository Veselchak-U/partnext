import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/form_fields/app_field_header.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

class AppDropdownField<T> extends StatefulWidget {
  final List<T> items;
  final T? initialItem;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Function(T?)? onChanged;
  final bool withSearch;
  final bool enabled;
  final bool loading;
  final OverlayPortalController? overlayController;
  final bool isRequired;

  const AppDropdownField({
    required this.items,
    this.initialItem,
    this.label,
    this.hint,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.withSearch = false,
    this.enabled = true,
    this.loading = false,
    this.overlayController,
    this.isRequired = false,
    super.key,
  });

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>> {
  final _formFieldKey = GlobalKey<FormFieldState<String>>();

  void _onDropdownOpened(bool value) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _formFieldKey,
      initialValue: widget.initialItem != null ? '${widget.initialItem}' : null,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      builder: (formState) {
        // final selectedValueText = _formFieldKey.currentState?.value;
        final hasError = formState.hasError;
        final borderColor = hasError ? AppColors.error : AppColors.border;

        final headerText = hasError ? formState.errorText : null;
        final headerTextColor = hasError ? AppColors.error : AppColors.text;
        final textColor = hasError ? AppColors.error : AppColors.text;

        final closedHeaderPadding = Directionality.of(context) == TextDirection.rtl
            ? const EdgeInsets.only(left: 8, right: 24).r
            : const EdgeInsets.only(left: 24, right: 8).r;

        final itemsListPadding = const EdgeInsets.symmetric(vertical: 24).r;

        final decoration = CustomDropdownDecoration(
          hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.disabled),
          headerStyle: AppTextStyles.s14w400,
          listItemStyle: AppTextStyles.s14w400,
          closedFillColor: AppColors.white,
          expandedBorder: Border.all(color: AppColors.primary, width: 1),
          expandedBorderRadius: BorderRadius.circular(8).r,
          closedSuffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Assets.icons.dropdownClosed.svg(
              width: 24.r,
              height: 24.r,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          ),
          expandedSuffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Assets.icons.dropdownExpanded.svg(width: 24.r, height: 24.r),
          ),
          searchFieldDecoration: SearchFieldDecoration(
            textStyle: AppTextStyles.s14w400,
            hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.gray.withValues(alpha: 255 * 0.5)),
          ),
        );

        final disabledDecoration = CustomDropdownDisabledDecoration(
          hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.gray.withValues(alpha: 255 * 0.5)),
          headerStyle: AppTextStyles.s14w400.copyWith(color: AppColors.gray.withValues(alpha: 255 * 0.5)),
          suffixIcon: const SizedBox.shrink(),
        );

        final outerHeight = max(58.0, 58.h);
        final innerHeight = max(50.0, 50.h);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              style: AppTextStyles.s14w400.copyWith(color: headerTextColor),
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.label ?? '',
                  ),
                  if (widget.isRequired)
                    TextSpan(
                      text: '\u{00A0}*',
                      style: AppTextStyles.s14w400.copyWith(color: AppColors.error),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: outerHeight,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: innerHeight,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8).r,
                          border: Border.all(color: borderColor, width: 1),
                        ),
                        child: widget.withSearch
                            ? CustomDropdown<T>.search(
                                searchHintText: context.l10n.search,
                                noResultFoundText: context.l10n.no_result_found,
                                items: widget.items,
                                initialItem: widget.initialItem,
                                onChanged: onChanged,
                                hideSelectedFieldWhenExpanded: true,
                                hintBuilder: hintBuilder,
                                headerBuilder: headerBuilder,
                                closedHeaderPadding: closedHeaderPadding,
                                itemsListPadding: itemsListPadding,
                                decoration: decoration,
                                disabledDecoration: disabledDecoration,
                                excludeSelected: false,
                                enabled: widget.enabled,
                                visibility: _onDropdownOpened,
                                overlayController: widget.overlayController,
                              )
                            : CustomDropdown<T>(
                                items: widget.items,
                                initialItem: widget.initialItem,
                                onChanged: onChanged,
                                hideSelectedFieldWhenExpanded: true,
                                hintBuilder: hintBuilder,
                                headerBuilder: headerBuilder,
                                closedHeaderPadding: closedHeaderPadding,
                                itemsListPadding: itemsListPadding,
                                decoration: decoration,
                                disabledDecoration: disabledDecoration,
                                excludeSelected: false,
                                enabled: widget.enabled,
                                visibility: _onDropdownOpened,
                              ),
                      ),
                      if (widget.loading) const LoadingIndicator(color: AppColors.red),
                    ],
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: 0,
                    start: 34.w,
                    child: AppFieldHeader(
                      text: headerText,
                      color: headerTextColor.withValues(alpha: widget.enabled ? 255 : 255 * 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void onChanged(T? value) {
    _formFieldKey.currentState?.didChange('$value');
    widget.onChanged?.call(value);
  }

  Widget hintBuilder(BuildContext context, String hint, bool enabled) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        widget.hint ?? '',
        style: AppTextStyles.s14w400.copyWith(color: AppColors.disabled.withValues(alpha: enabled ? 1 : 0.5)),
      ),
    );
  }

  Widget headerBuilder(BuildContext context, T item, bool enabled) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        '$item',
        style: AppTextStyles.s14w400.copyWith(color: AppColors.text.withValues(alpha: enabled ? 1 : 0.5)),
      ),
    );
  }
}
