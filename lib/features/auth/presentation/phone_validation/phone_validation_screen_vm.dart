import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/auth/presentation/phone_validation/phone_validation_screen_params.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class PhoneValidationScreenVm {
  final BuildContext _context;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final QuestionnaireRepository _questionnaireRepository;
  final PhoneValidationScreenParams params;

  PhoneValidationScreenVm(
    this._context,
    this._authRepository,
    this._userRepository,
    this._questionnaireRepository, {
    required this.params,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  final formKey = GlobalKey<FormState>();

  String _code = '';

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  void onCodeChanged(String value) {
    _code = value;
  }

  Future<void> resendOtp() async {
    FocusScope.of(_context).unfocus();

    _setLoading(true);
    try {
      await _authRepository.requestOtp(params.phone);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> login() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      final user = await _authRepository.login(params.phone, _code);
      await _userRepository.setUser(user);

      _checkQuestionnaire();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> _checkQuestionnaire() async {
    _setLoading(true);
    try {
      final questionnaire = await _questionnaireRepository.getQuestionnaire();
      await _userRepository.setQuestionnaire(questionnaire);

      if (questionnaire?.isComplete == true) {
        _goHome();
      } else {
        _goQuestionnaire();
      }
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goHome() {
    if (!_context.mounted) return;
    _context.goNamed(AppRoute.home.name);
  }

  void _goQuestionnaire() {
    if (!_context.mounted) return;
    _context.goNamed(AppRoute.questionnaire.name);
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
