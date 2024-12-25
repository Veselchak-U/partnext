import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AppPhoneField extends StatefulWidget {
  final String label;
  final bool autofocus;
  final void Function(String)? onChanged;

  const AppPhoneField({
    required this.label,
    this.autofocus = false,
    this.onChanged,
    super.key,
  });

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  final _phoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.IL, nsn: ''),
  );

  final _showClearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    _showClearButton.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final phone = _phoneController.value;
    _showClearButton.value = phone.nsn.isNotEmpty;
    widget.onChanged?.call(phone.international);
  }

  void _onClearPhone() {
    _showClearButton.value = false;
    final isoCode = _phoneController.value.isoCode;
    _phoneController.value = PhoneNumber(isoCode: isoCode, nsn: '');
    widget.onChanged?.call('');
  }

  String? _phoneValidator(PhoneNumber? value) {
    if (value == null) return null;

    if (!value.isValidLength()) {
      return context.l10n.invalid_phone_number;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.s14w400;
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.disabled),
      borderRadius: BorderRadius.circular(8).r,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: textStyle,
        ),
        SizedBox(height: 10.h),
        Stack(
          alignment: Alignment.topRight,
          children: [
            PhoneFormField(
              controller: _phoneController,
              validator: PhoneValidator.compose([
                PhoneValidator.required(
                  context,
                  errorText: context.l10n.invalid_phone_number,
                ),
                _phoneValidator,
              ]),
              countrySelectorNavigator: const CountrySelectorNavigator.draggableBottomSheet(
                // countries: [IsoCode.IL],
                favorites: [IsoCode.IL],
              ),
              countryButtonStyle: CountryButtonStyle(
                padding: EdgeInsets.only(left: 16).w,
                showDialCode: true,
                showIsoCode: true,
                showFlag: true,
                textStyle: textStyle,
              ),
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              style: textStyle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15).h,
                filled: true,
                fillColor: AppColors.white,
                border: inputBorder,
                enabledBorder: inputBorder.copyWith(
                  borderSide: BorderSide(width: 1, color: AppColors.border),
                ),
                focusedBorder: inputBorder.copyWith(
                  borderSide: BorderSide(width: 1, color: AppColors.primary),
                ),
                errorBorder: inputBorder.copyWith(
                  borderSide: BorderSide(width: 1, color: AppColors.red),
                ),
                focusedErrorBorder: inputBorder.copyWith(
                  borderSide: BorderSide(width: 1, color: AppColors.red),
                ),
                errorStyle: AppTextStyles.s14w400.copyWith(color: AppColors.red),
              ),
              autofocus: widget.autofocus,
            ),
            ValueListenableBuilder(
              valueListenable: _showClearButton,
              builder: (context, showClearButton, _) {
                if (!showClearButton) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(top: 2).h,
                  child: IconButton(
                    icon: const Icon(Icons.cancel, color: AppColors.gray),
                    onPressed: _onClearPhone,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
