import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/change_locale_button.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/form_fields/app_text_field.dart';
import 'package:partnext/common/layouts/gradient_layout.dart';
import 'package:partnext/common/utils/input_validators.dart';
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen_vm.dart';
import 'package:provider/provider.dart';

class PhoneValidationScreen extends StatefulWidget {
  const PhoneValidationScreen({super.key});

  @override
  State<PhoneValidationScreen> createState() => _PhoneValidationScreenState();
}

class _PhoneValidationScreenState extends State<PhoneValidationScreen> {
  final passwordFormatter = MaskTextInputFormatter(mask: '######');

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PhoneValidationScreenVm>();

    return Stack(
      children: [
        GradientLayout(
          body: Form(
            key: vm.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32).w,
              child: Column(
                children: [
                  SizedBox(height: 9.h),
                  Text(
                    context.l10n.phone_validation,
                    style: AppTextStyles.s20w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 52.h),
                  AppTextField(
                    label: context.l10n.enter_validation_code,
                    hint: 'XXXXXX',
                    autofocus: true,
                    inputFormatters: [passwordFormatter],
                    validator: InputValidators.passwordLengthValidator,
                    keyboardType: TextInputType.number,
                    onChanged: vm.onCodeChanged,
                  ),
                  SizedBox(height: 28.h),
                  ValueListenableBuilder(
                    valueListenable: vm.loading,
                    builder: (context, loading, _) {
                      return CommonButton(
                        label: context.l10n.next,
                        iconPath: Assets.icons.send.path,
                        onTap: vm.login,
                        loading: loading,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.did_not_get_code,
                        style: AppTextStyles.s14w400,
                      ),
                      TextButton(
                        onPressed: vm.resendOtp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8).w,
                          child: Text(context.l10n.resend_code),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: MediaQuery.of(context).viewPadding.top,
          end: 8.w,
          child: ChangeLocaleButton(isDebug: false),
        ),
      ],
    );
  }
}
