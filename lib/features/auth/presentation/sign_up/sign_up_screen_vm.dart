import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/string_ext.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';

class SignUpScreenVm {
  final BuildContext _context;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignUpScreenVm(
    this._context,
    this._authRepository,
    this._userRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final termsConfirmed = ValueNotifier<bool>(false);
  final termsMustAccepted = ValueNotifier<bool>(false);

  final pageController = PageController();

  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  String _fullName = '';
  String _phone = '';
  String _code = '';

  void _init() {}

  void dispose() {
    loading.dispose();
    termsConfirmed.dispose();
    termsMustAccepted.dispose();

    pageController.dispose();
  }

  void onFullNameChanged(String value) {
    _fullName = value;
  }

  void onPhoneChanged(String value) {
    final normalizedPhone = value.removeLeadingSymbols('0');
    _phone = normalizedPhone;
  }

  void onCodeChanged(String value) {
    _code = value;
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

  Future<void> sendOtp() async {
    FocusScope.of(_context).unfocus();

    final validForm = firstFormKey.currentState?.validate();
    if (validForm == false) return;

    if (!termsConfirmed.value) {
      termsMustAccepted.value = true;
      _onError(_context.l10n.terms_must_accepted);

      return;
    }

    _setLoading(true);
    try {
      await _authRepository.register(_fullName, _phone);
      await _authRepository.requestOtp(_phone);

      if (!_context.mounted) return;
      goNextPage();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> resendOtp() async {
    FocusScope.of(_context).unfocus();

    _setLoading(true);
    try {
      await _authRepository.requestOtp(_phone);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> login() async {
    FocusScope.of(_context).unfocus();

    final validForm = secondFormKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      final user = await _authRepository.login(_phone, _code);
      await _userRepository.setUser(user);

      if (!_context.mounted) return;
      _context.goNamed(AppRoute.questionnaire.name);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void goNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
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
