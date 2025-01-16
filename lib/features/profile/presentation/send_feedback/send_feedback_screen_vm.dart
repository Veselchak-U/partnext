import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen_params.dart';

class SendFeedbackScreenVm {
  final BuildContext _context;
  final ProfileRepository _profileRepository;

  SendFeedbackScreenVm(
    this._context,
    this._profileRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  final formKey = GlobalKey<FormState>();

  String message = '';

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  Future<void> sendFeedback() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      await _profileRepository.sendFeedback(message);

      _goFeedbackAccepted();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goFeedbackAccepted() {
    if (!_context.mounted) return;
    _context.goNamed(
      AppRoute.actionResult.name,
      extra: ActionResultScreenParams(
        title: _context.l10n.feedback_accepted,
        description: _context.l10n.thank_you_for_taking_time,
      ),
    );
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message, {bool isError = true}) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message, isError: isError);
  }
}
