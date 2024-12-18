import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/form_fields/app_phone_field.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/features/auth/presentation/login/login_screen_vm.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginScreenVm>();

    return MainSimpleLayout(
      body: Form(
        key: vm.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32).w,
          child: Column(
            children: [
              SizedBox(height: 9.h),
              Text(
                context.l10n.login,
                style: AppTextStyles.s20w700,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              AppPhoneField(
                label: context.l10n.phone_number,
                autofocus: true,
                onChanged: vm.onPhoneChanged,
              ),
              const Spacer(flex: 4),
              ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return CommonButton(
                    label: context.l10n.next,
                    iconPath: Assets.icons.send.path,
                    onTap: vm.onNext,
                    loading: loading,
                  );
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.do_not_have_account,
                    style: AppTextStyles.s14w400,
                  ),
                  TextButton(
                    onPressed: vm.goSignUp,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8).w,
                      child: Text(context.l10n.registration),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
