import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';

class LoginScreenVm {
  final BuildContext _context;
  // final AuthRepository _authRepository;
  // final UserRepository _userRepository;

  LoginScreenVm(
    this._context,
    // this._authRepository,
    // this._userRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final otpSend = ValueNotifier<bool>(false);
  final codeFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String _phone = '';
  String _code = '';

  void _init() {}

  void dispose() {
    loading.dispose();
    otpSend.dispose();
    codeFocusNode.dispose();
  }

  void onPhoneChanged(String value) {
    _phone = value;
    _clearCode();
  }

  void _clearCode() {
    if (otpSend.value) {
      otpSend.value = false;
      _code = '';
    }
  }

  void onCodeChanged(String value) {
    _code = value;
  }

  Future<void> requestCode() async {
    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      // await _authRepository.requestOtp(_phone);
      //
      // otpSend.value = true;
      // codeFocusNode.requestFocus();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> login() async {
    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      // final user = await _authRepository.login(_phone, _code);
      // await _userRepository.setUser(user);
      //
      // if (!_context.mounted) return;
      // final userBaseInfoRequired = user.baseInformation == null;
      // _context.goNamed(
      //   userBaseInfoRequired ? AppRoute.userBaseInfoForm.name : AppRoute.home.name,
      // );
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void goSignUp() {
    _context.goNamed(AppRoute.signUp.name);
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
