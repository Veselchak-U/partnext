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
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/auth/presentation/login/login_screen.dart';
import 'package:partnext/features/auth/presentation/login/login_screen_vm.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen_vm.dart';
import 'package:partnext/features/auth/presentation/sign_up_success/sign_up_success_screen.dart';
import 'package:partnext/features/home/presentation/home_screen.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/initial/presentation/initial_screen.dart';
import 'package:partnext/features/initial/presentation/initial_screen_vm.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/welcome/presentation/welcome_screen.dart';
import 'package:provider/provider.dart';

class AppNavigation {
  static final _allowingWithoutAuthorization = [
    AppRoute.initial.path,
    AppRoute.welcome.path,
    AppRoute.login.path,
    AppRoute.signUp.path,
  ];

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static Future<bool> _isUnauthorizedUser() async {
    final token = await DI.get<UserRepository>().getAccessToken();

    return token == null;
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
      GoRoute(
        name: AppRoute.initial.name,
        path: AppRoute.initial.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: Provider(
            lazy: false,
            create: (context) => InitialScreenVm(
              context,
              DI.get<InitialController>(),
            ),
            dispose: (context, vm) => vm.dispose(),
            child: const InitialScreen(),
          ),
        ),
      ),
      GoRoute(
        name: AppRoute.welcome.name,
        path: AppRoute.welcome.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: const WelcomeScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.login.name,
        path: AppRoute.login.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => LoginScreenVm(
            context,
            // DI.get<AuthRepository>(),
            // DI.get<UserRepository>(),
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.signUp.name,
        path: AppRoute.signUp.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => SignUpScreenVm(
            context,
            DI.get<AuthRepository>(),
            DI.get<UserRepository>(),
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.questionnaire.name,
        path: AppRoute.questionnaire.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => QuestionnaireScreenVm(
            context,
            DI.get<QuestionnaireRepository>(),
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const QuestionnaireScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.signUpSuccess.name,
        path: AppRoute.signUpSuccess.path,
        builder: (context, state) => const SignUpSuccessScreen(),
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
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
