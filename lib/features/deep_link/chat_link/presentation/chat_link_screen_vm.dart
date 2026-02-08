import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';

import '../../../nav_bar/domain/provider/nav_bar_index_provider.dart';

class ChatLinkScreenVm {
  final BuildContext _context;
  final NavBarIndexProvider _navBarIndexProvider;
  final ChatRepository _chatRepository;
  final int? chatId;

  ChatLinkScreenVm(
    this._context,
    this._navBarIndexProvider,
    this._chatRepository, {
    required this.chatId,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(true);
  final chat = ValueNotifier<ChatApiModel?>(null);

  void _init() {
    _getChat();
  }

  void dispose() {
    loading.dispose();
    chat.dispose();
  }

  void goHome() {
    _setLoading(true);
    _navBarIndexProvider.navBarIndex = NavBarTab.home.index;

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.home.name,
      );
    });
  }

  Future<void> _getChat() async {
    final id = chatId;
    if (id == null) {
      _setLoading(false);
      return;
    }

    try {
      final chats = await _chatRepository.getChats();

      if (!_context.mounted) return;
      final founded = chats.firstWhereOrNull((e) => e.id == id);
      if (founded != null) {
        chat.value = founded;
        _goChatScreen(founded.id);
      }
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goChatScreen(int chatId) {
    if (!_context.mounted) return;

    _navBarIndexProvider.navBarIndex = NavBarTab.chats.index;

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.messages.name,
        extra: chatId,
      );
    });
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
