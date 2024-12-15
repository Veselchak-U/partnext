import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('HomeScreen')),
          SizedBox(height: 24.h),
          TextButton(
            onPressed: vm.logOut,
            child: Text('Log out'),
          )
        ],
      ),
    );
  }
}
