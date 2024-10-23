import 'package:flutter/services.dart';

class InputFormatters {
  static final onlyDigits = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static final sumFormatter = FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'));
}
