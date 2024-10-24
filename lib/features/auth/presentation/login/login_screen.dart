import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/auth/presentation/login/login_screen_vm.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginScreenVm>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('LoginScreen'),
          SizedBox(height: 23.h),
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
        ],
      ),
    );
  }
}
