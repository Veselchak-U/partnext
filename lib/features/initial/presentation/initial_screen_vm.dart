import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';

class InitialScreenVm {
  final BuildContext _context;
  final InitialController _initialController;
  final RefreshUserProfileUseCase _refreshUserProfileUseCase;

  InitialScreenVm(
    this._context,
    this._initialController,
    this._refreshUserProfileUseCase,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(true);

  void _init() {
    _initialController.addListener(_initialControllerListener);
    Future.delayed(
      const Duration(seconds: 1),
      _initialController.authChecking,
    );
  }

  void dispose() {
    _initialController.removeListener(_initialControllerListener);
    _initialController.dispose();

    loading.dispose();
  }

  void _initialControllerListener() {
    final state = _initialController.state;
    _handleLoading(state);
    _handleState(state);
    _handleError(state);
  }

  void _handleLoading(InitialControllerState state) {
    loading.value = switch (state) {
      const InitialController$Loading() => true,
      _ => false,
    };
  }

  void _handleState(InitialControllerState state) {
    final nextScreen = switch (state) {
      const InitialController$Unauthorized() => AppRoute.welcome.name,
      const InitialController$QuestionnaireRequired() => AppRoute.questionnaire.name,
      const InitialController$Success() => AppRoute.home.name,
      _ => null,
    };

    if (nextScreen == null) return;

    // Refresh the user profile every time the application is launched
    if (nextScreen == AppRoute.home.name) {
      _refreshUserProfileUseCase();
    }

    LoggerService().d('InitialScreenVm: nextScreen = "$nextScreen"');
    _context.goNamed(nextScreen);
  }

  void _handleError(InitialControllerState state) {
    switch (state) {
      case InitialController$Error():
        AppOverlays.showErrorBanner('${state.error}');
        break;
      default:
        break;
    }
  }
}
