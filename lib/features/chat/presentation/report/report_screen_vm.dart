import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/presentation/report/report_screen_params.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen_params.dart';

class ReportScreenVm {
  final BuildContext _context;
  final ChatRepository _chatRepository;
  final ReportScreenParams params;

  ReportScreenVm(
    this._context,
    this._chatRepository, {
    required this.params,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  final formKey = GlobalKey<FormState>();

  String description = '';

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  Future<void> sendReport() async {
    FocusScope.of(_context).unfocus();

    final validForm = formKey.currentState?.validate();
    if (validForm == false) return;

    _setLoading(true);
    try {
      await _chatRepository.report(
        chatId: params.chat.id,
        description: description,
        messageId: params.message?.id,
      );

      _goReportSuccess();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goReportSuccess() {
    if (!_context.mounted) return;
    _context.pushNamed(
      AppRoute.actionResult.name,
      extra: ActionResultScreenParams(
        title: _context.l10n.thank_you_for_reporting_user,
        description: _context.l10n.your_report_will_be_reviewed,
        buttonLabel: _context.l10n.back_to_chats,
        onTap: _goMessageListScreen,
      ),
    );
  }

  void _goMessageListScreen() {
    if (!_context.mounted) return;
    _context.pop();
    _context.pop();
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
