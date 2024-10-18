import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/di.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_navigation_observer.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/navigation/navigation_error_screen.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';

class AppNavigation {
  static final _allowingWithoutAuthorization = [
    AppRoute.initial.path,
    AppRoute.signUp.path,
    AppRoute.verifyPhone.path,
    AppRoute.login.path,
  ];

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static Future<bool> _isUnauthorizedUser() async {
    return true;

    // final token = await DI.get<UserRepository>().getAccessToken();
    //
    // return token == null;
  }

  static void goToScreen({required String name}) {
    final context = _rootNavigatorKey.currentContext;
    if (context != null) {
      LoggerService().d('AppNavigation.goToScreen($name)');
      context.goNamed(name);
    } else {
      LoggerService().d('AppNavigation.goToScreen($name) cancelled - context == null');
    }
  }

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.initial.path,
    redirect: _redirect,
    observers: [DI.get<AppNavigationObserver>()],
    errorBuilder: (context, state) {
      LoggerService().e(message: 'AppNavigation', error: state.error, stackTrace: StackTrace.current);

      return NavigationErrorScreen(state.error);
    },
    routes: [
      // GoRoute(
      //   name: AppRoute.initial.name,
      //   path: AppRoute.initial.path,
      //   pageBuilder: (context, state) => NoTransitionPage(
      //     child: Provider(
      //       lazy: false,
      //       create: (context) => InitialScreenVm(
      //         context,
      //         DI.get<InitialController>(),
      //       ),
      //       dispose: (context, vm) => vm.dispose(),
      //       child: const InitialScreen(),
      //     ),
      //   ),
      // ),
    ],
  );

  static FutureOr<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    LoggerService().d('AppNavigation navigate to "${state.uri.toString()}"');
    if (await _isUnauthorizedUser()) {
      final currentLocation = state.uri.toString();
      if (!_allowingWithoutAuthorization.contains(currentLocation)) {
        if (context.mounted) AppOverlays.showErrorBanner(context.l10n.go_to_login_screen);
        LoggerService().d('AppNavigation._redirect("${AppRoute.login.path}")');

        return AppRoute.login.path;
      }
    }

    return null;
  }
}
