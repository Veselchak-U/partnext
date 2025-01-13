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
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen.dart';
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen_params.dart';
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen_vm.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:partnext/features/auth/presentation/sign_up/sign_up_screen_vm.dart';
import 'package:partnext/features/auth/presentation/sign_up_success/sign_up_success_screen.dart';
import 'package:partnext/features/home/presentation/home_screen.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/initial/presentation/initial_screen.dart';
import 'package:partnext/features/initial/presentation/initial_screen_vm.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/nav_bar/presentation/nav_bar_screen.dart';
import 'package:partnext/features/nav_bar/presentation/nav_bar_screen_vm.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/presentation/profile_screen.dart';
import 'package:partnext/features/profile/presentation/profile_screen_vm.dart';
import 'package:partnext/features/profile/presentation/send_feedback/feedback_accepted_screen.dart';
import 'package:partnext/features/profile/presentation/send_feedback/send_feedback_screen.dart';
import 'package:partnext/features/profile/presentation/send_feedback/send_feedback_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_params.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/welcome/presentation/welcome_screen.dart';
import 'package:provider/provider.dart';

class AppNavigation {
  static final _allowingWithoutAuthorization = [
    AppRoute.initial.path,
    AppRoute.welcome.path,
    AppRoute.login.path,
    AppRoute.signUp.path,
    AppRoute.phoneValidation.path,
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
            DI.get<AuthRepository>(),
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
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.phoneValidation.name,
        path: AppRoute.phoneValidation.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => PhoneValidationScreenVm(
            context,
            DI.get<AuthRepository>(),
            DI.get<UserRepository>(),
            DI.get<QuestionnaireRepository>(),
            params: state.extra as PhoneValidationScreenParams,
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const PhoneValidationScreen(),
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
            params: state.extra as QuestionnaireScreenParams?,
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
      StatefulShellRoute.indexedStack(
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return Provider(
            lazy: false,
            create: (context) => NavBarScreenVm(
              context,
              DI.get<NavBarIndexProvider>(),
            ),
            dispose: (context, vm) => vm.dispose(),
            child: NavBarScreen(navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.home.name,
                path: AppRoute.home.path,
                builder: (context, state) => Provider(
                  lazy: false,
                  create: (context) => HomeScreenVm(
                    context,
                    DI.get<PartnerRepository>(),
                    DI.get<UserRepository>(),
                  ),
                  dispose: (context, vm) => vm.dispose(),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.profile.name,
                path: AppRoute.profile.path,
                builder: (context, state) => Provider(
                  lazy: false,
                  create: (context) => ProfileScreenVm(
                    context,
                    DI.get<UserRepository>(),
                    DI.get<ProfileRepository>(),
                  ),
                  dispose: (context, vm) => vm.dispose(),
                  child: const ProfileScreen(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoute.sendFeedback.name,
                    path: AppRoute.sendFeedback.path,
                    builder: (context, state) => Provider(
                      lazy: false,
                      create: (context) => SendFeedbackScreenVm(
                        context,
                        DI.get<ProfileRepository>(),
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const SendFeedbackScreen(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoute.upgrade.name,
                    path: AppRoute.upgrade.path,
                    builder: (context, state) => Provider(
                      lazy: false,
                      create: (context) => UpgradeScreenVm(
                        context,
                        DI.get<UserRepository>(),
                        DI.get<ProfileRepository>(),
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const UpgradeScreen(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                name: AppRoute.feedbackAccepted.name,
                path: AppRoute.feedbackAccepted.path,
                builder: (context, state) => FeedbackAcceptedScreen(
                  navBarIndexProvider: DI.get<NavBarIndexProvider>(),
                ),
              ),
            ],
          ),
        ],
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
