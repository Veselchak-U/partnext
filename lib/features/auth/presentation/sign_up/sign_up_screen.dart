import 'package:flutter/material.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen_vm.dart';
import 'package:partnext/features/auth/presentation/sign_up/widgets/sign_up_first_page.dart';
import 'package:partnext/features/auth/presentation/sign_up/widgets/sign_up_second_page.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpScreenVm vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<SignUpScreenVm>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        reverse: context.locale.isRtl,
        controller: vm.pageController,
        children: const [
          SignUpFirstPage(),
          SignUpSecondPage(),
        ],
      ),
    );
  }
}
