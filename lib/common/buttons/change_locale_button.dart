import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/config.dart';

class ChangeLocaleButton extends StatelessWidget {
  final bool isDebug;

  const ChangeLocaleButton({
    this.isDebug = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isDebug
        ? ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(Colors.grey.withValues(alpha: 0.3)),
            foregroundColor: const WidgetStatePropertyAll<Color?>(Colors.white),
            fixedSize: WidgetStatePropertyAll<Size?>(Size.square(42.r)),
          )
        : ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(Colors.white),
            foregroundColor: const WidgetStatePropertyAll<Color?>(Colors.black),
            fixedSize: WidgetStatePropertyAll<Size?>(Size.square(42.r)),
          );

    return Config.isProdBuild && isDebug
        ? const SizedBox.shrink()
        : IconButton(
            onPressed: () => _changeLocale(context),
            icon: const Icon(Icons.translate),
            iconSize: 24.r,
            style: buttonStyle,
          );
  }

  void _changeLocale(BuildContext context) {
    final locale = context.locale;
    final newLocale = locale.languageCode == 'he' ? const Locale('en', 'US') : const Locale('he', 'HE');
    context.locale = newLocale;
  }
}
