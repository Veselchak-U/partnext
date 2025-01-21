import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';

class AppShadows {
  static const questionnaireItem = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 10.1,
    spreadRadius: 0,
    offset: Offset(0, 0),
  );

  static const bottomNavBar = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 4.0,
    spreadRadius: 0,
    offset: Offset(0, -2),
  );

  static const container = BoxShadow(
    color: Color.fromRGBO(126, 126, 126, 0.33),
    blurRadius: 10.1,
    spreadRadius: 0,
    offset: Offset(0, 3),
  );
}
