import 'package:flutter/material.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/gen/app_localizations.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_navigation.dart';
import 'package:partnext/app/style/app_theme.dart';
import 'package:partnext/common/overlays/app_overlays.dart';

class App extends StatefulWidget {
  const App({super.key});

  static void setLocale(BuildContext context, Locale value) {
    final appState = context.findAncestorStateOfType<_AppState>();
    appState?.setLocale(value);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _locale = ValueNotifier<Locale>(const Locale('en'));

  @override
  void dispose() {
    _locale.dispose();
    super.dispose();
  }

  void setLocale(Locale value) {
    _locale.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      child: ValueListenableBuilder(
        valueListenable: _locale,
        builder: (context, locale, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppNavigation.router,
            locale: locale,
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              ...CountrySelectorLocalization.localizationsDelegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.light,
            scaffoldMessengerKey: _scaffoldMessengerKey,
            builder: (context, child) {
              l10n = context.l10n;
              l10nLocale = locale;

              AppOverlays.init(
                scaffoldMessengerKey: _scaffoldMessengerKey,
                theme: AppTheme.light,
              );

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
