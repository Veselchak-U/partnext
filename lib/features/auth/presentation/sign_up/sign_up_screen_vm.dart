import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/string_ext.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/auth/repository/auth_repository.dart';

class SignUpScreenVm {
  final BuildContext _context;
  final AuthRepository _authRepository;

  SignUpScreenVm(
    this._context,
    this._authRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final termsConfirmed = ValueNotifier<bool>(false);
  final termsMustAccepted = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _phone = '';

  void _init() {}

  void dispose() {
    loading.dispose();
    termsConfirmed.dispose();
    termsMustAccepted.dispose();
  }

  void onFullNameChanged(String value) {
    _fullName = value;
  }

  void onPhoneChanged(String value) {
    _phone = value;
  }

  void onTermsConfirmedChanged(bool? value) {
    if (value == null) return;

    termsConfirmed.value = value;
    if (value) termsMustAccepted.value = false;
  }

  void openTermsAndConditions() {
    UrlLauncher.launchURL(Config.termsAndConditionsUrl);
  }

  void openPrivacyPolicy() {
    UrlLauncher.launchURL(Config.privacyPolicyUrl);
  }

  void goLogin() {
    _context.goNamed(AppRoute.login.name);
  }

  Future<void> goPhoneValidation() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    if (!termsConfirmed.value) {
      termsMustAccepted.value = true;
      _onError(_context.l10n.terms_must_accepted);

      return;
    }

    _setLoading(true);
    try {
      final normalizedPhone = _phone.removeLeadingSymbols('0');
      await _authRepository.requestOtp(normalizedPhone);

      if (!_context.mounted) return;
      _context.pushNamed(
        AppRoute.verifyPhone.name,
        extra: normalizedPhone,
      );
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> createAccount() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    if (!termsConfirmed.value) {
      termsMustAccepted.value = true;
      _onError(_context.l10n.terms_must_accepted);

      return;
    }

    _setLoading(true);
    try {
      // final normalizedPhone = _phone.removeLeadingSymbols('0');

      // final model = RegistrationApiModel(
      //   firstName: _firstName,
      //   lastName: _lastName,
      //   phone: normalizedPhone,
      // );
      //
      // await _authRepository.register(model);
      // await _authRepository.requestOtp(normalizedPhone);
      //
      // if (!_context.mounted) return;
      // _context.pushNamed(
      //   AppRoute.verifyPhone.name,
      //   extra: normalizedPhone,
      // );
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    loading.value = value;
  }

  void _onError(String message) {
    AppOverlays.showErrorBanner(message);
  }
}
