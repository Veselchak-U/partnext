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
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/chat/presentation/chat_list_screen.dart';
import 'package:partnext/features/chat/presentation/chat_list_screen_vm.dart';
import 'package:partnext/features/chat/presentation/message_list/message_list_screen.dart';
import 'package:partnext/features/chat/presentation/message_list/message_list_screen_vm.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen_params.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/grow/presentation/grow_screen.dart';
import 'package:partnext/features/grow/presentation/grow_screen_vm.dart';
import 'package:partnext/features/grow/presentation/partner_details/partner_details_screen.dart';
import 'package:partnext/features/grow/presentation/partner_details/partner_details_screen_vm.dart';
import 'package:partnext/features/grow/presentation/start_chat/start_chat_screen.dart';
import 'package:partnext/features/grow/presentation/start_chat/start_chat_screen_vm.dart';
import 'package:partnext/features/home/presentation/home_screen.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/initial/presentation/initial_screen.dart';
import 'package:partnext/features/initial/presentation/initial_screen_vm.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/nav_bar/presentation/nav_bar_screen.dart';
import 'package:partnext/features/nav_bar/presentation/nav_bar_screen_vm.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/domain/use_case/logout_use_case.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen_params.dart';
import 'package:partnext/features/profile/presentation/profile_screen.dart';
import 'package:partnext/features/profile/presentation/profile_screen_vm.dart';
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
            DI.get<FileRepository>(),
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
              DI.get<NavBarIndexProvider>(),
              DI.get<ChatListProvider>(),
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
                name: AppRoute.chats.name,
                path: AppRoute.chats.path,
                builder: (context, state) => Provider(
                  lazy: false,
                  create: (context) => ChatListScreenVm(
                    context,
                    DI.get<ChatListProvider>(),
                  ),
                  dispose: (context, vm) => vm.dispose(),
                  child: const ChatListScreen(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoute.messages.name,
                    path: AppRoute.messages.path,
                    builder: (context, state) => Provider(
                      lazy: false,
                      create: (context) => MessageListScreenVm(
                        context,
                        DI.get<MessageListProvider>(),
                        DI.get<FileRepository>(),
                        chat: state.extra as ChatApiModel,
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const MessageListScreen(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoute.viewImage.name,
                    path: AppRoute.viewImage.path,
                    builder: (context, state) => ViewImageScreen(
                      params: state.extra as ViewImageScreenParams,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.grow.name,
                path: AppRoute.grow.path,
                builder: (context, state) => Provider(
                  lazy: false,
                  create: (context) => GrowScreenVm(
                    context,
                    DI.get<PartnersProvider>(),
                    DI.get<UserRepository>(),
                    DI.get<NavBarIndexProvider>(),
                  ),
                  dispose: (context, vm) => vm.dispose(),
                  child: const GrowScreen(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoute.partnerDetails.name,
                    path: AppRoute.partnerDetails.path,
                    builder: (context, state) => Provider(
                      lazy: false,
                      create: (context) => PartnerDetailsScreenVm(
                        context,
                        DI.get<PartnersProvider>(),
                        partner: state.extra as PartnerApiModel,
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const PartnerDetailsScreen(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoute.startChat.name,
                    path: AppRoute.startChat.path,
                    builder: (context, state) => Provider(
                      lazy: false,
                      create: (context) => StartChatScreenVm(
                        context,
                        DI.get<ChatListProvider>(),
                        DI.get<UserRepository>(),
                        DI.get<NavBarIndexProvider>(),
                        partner: state.extra as PartnerApiModel,
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const StartChatScreen(),
                    ),
                  ),
                ],
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
                    DI.get<LogoutUseCase>(),
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
                        DI.get<RefreshUserProfileUseCase>(),
                      ),
                      dispose: (context, vm) => vm.dispose(),
                      child: const UpgradeScreen(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                name: AppRoute.actionResult.name,
                path: AppRoute.actionResult.path,
                builder: (context, state) => ActionResultScreen(
                  navBarIndexProvider: DI.get<NavBarIndexProvider>(),
                  params: state.extra as ActionResultScreenParams,
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
