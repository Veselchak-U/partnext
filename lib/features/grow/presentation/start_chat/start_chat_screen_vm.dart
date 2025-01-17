import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class StartChatScreenVm {
  final BuildContext _context;
  final ChatRepository _chatRepository;
  final PartnerApiModel partner;

  StartChatScreenVm(
    this._context,
    this._chatRepository, {
    required this.partner,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  Future<void> onStartConversation() async {
    _setLoading(true);
    try {
      final chat = await _chatRepository.createChat(partner.id);
      await _chatRepository.createChat(partner.id);

      _goChatScreen(chat.id);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goChatScreen(int chatId) {
    if (!_context.mounted) return;
    _context.pushNamed(
      AppRoute.chat.name,
      extra: chatId,
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
