import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen_params.dart';

class LoginScreenVm {
  final BuildContext _context;
  final AuthRepository _authRepository;

  LoginScreenVm(
    this._context,
    this._authRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  final formKey = GlobalKey<FormState>();

  String _phone = '';

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  void onPhoneChanged(String value) {
    _phone = value;
  }

  void goSignUp() {
    _context.goNamed(AppRoute.signUp.name);
  }

  Future<void> onNext() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      await _authRepository.requestOtp(_phone);

      if (!_context.mounted) return;
      _goPhoneValidation();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goPhoneValidation() {
    _context.pushNamed(
      AppRoute.phoneValidation.name,
      extra: PhoneValidationScreenParams(phone: _phone),
    );
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message);
  }
}
