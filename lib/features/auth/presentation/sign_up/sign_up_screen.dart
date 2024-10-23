import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/form_fields/app_phone_field.dart';
import 'package:partnext/common/form_fields/app_text_field.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/common/utils/input_validators.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen_vm.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignUpScreenVm>();

    return MainSimpleLayout(
      body: Form(
        key: vm.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32).w,
          child: Column(
            children: [
              SizedBox(height: 9.h),
              Text(
                context.l10n.registration,
                style: AppTextStyles.s20w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 52.h),
              AppTextField(
                label: context.l10n.full_name,
                validator: InputValidators.emptyValidator,
                onChanged: vm.onFullNameChanged,
              ),
              SizedBox(height: 16.h),
              AppPhoneField(
                label: context.l10n.phone_number,
                onChanged: vm.onPhoneChanged,
              ),
              SizedBox(height: 112.h),
              ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return CommonButton(
                    label: context.l10n.next,
                    iconPath: Assets.icons.send.path,
                    onTap: vm.goPhoneValidation,
                    loading: loading,
                  );
                },
              ),
              SizedBox(height: 17.h),
              ValueListenableBuilder(
                valueListenable: vm.termsConfirmed,
                builder: (context, termsConfirmed, _) {
                  return ValueListenableBuilder(
                    valueListenable: vm.termsMustAccepted,
                    builder: (context, termsMustAccepted, _) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: termsConfirmed,
                            side: BorderSide(
                              color: termsMustAccepted ? AppColors.red : AppColors.primary,
                              width: 2,
                            ),
                            onChanged: vm.onTermsConfirmedChanged,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12).h,
                              child: Text.rich(
                                style: AppTextStyles.s12w400,
                                TextSpan(
                                  children: [
                                    TextSpan(text: '${context.l10n.i_accept} '),
                                    TextSpan(
                                      text: context.l10n.terms_and_conditions,
                                      style: AppTextStyles.s12w400.copyWith(
                                        color: AppColors.primaryLight,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = vm.openTermsAndConditions,
                                    ),
                                    TextSpan(text: ' ${context.l10n.and} '),
                                    TextSpan(
                                      text: context.l10n.privacy_policy,
                                      style: AppTextStyles.s12w400.copyWith(
                                        color: AppColors.primaryLight,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = vm.openPrivacyPolicy,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 23.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.already_have_account,
                    style: AppTextStyles.s14w400,
                  ),
                  TextButton(
                    onPressed: vm.goLogin,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8).w,
                      child: Text(context.l10n.login),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
