import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';

class ChatListScreenVm {
  final BuildContext _context;
  final ChatListProvider _chatListProvider;

  ChatListScreenVm(
    this._context,
    this._chatListProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final chats = ValueNotifier<List<ChatApiModel>?>(null);

  void _init() {
    _chatListProvider.addListener(_chatListListener);
    _refreshChats();
  }

  void dispose() {
    _chatListProvider.removeListener(_chatListListener);

    loading.dispose();
    chats.dispose();
  }

  Future<void> _refreshChats() async {
    _setLoading(true);
    await _chatListProvider.startChecking(onError: _handleError);
    _setLoading(false);
  }

  void _handleError(Object e, StackTrace st) {
    LoggerService().e(error: e, stackTrace: st);
    _onError('$e');
  }

  void onRefresh() {
    _refreshChats();
  }

  void openChat(ChatApiModel chat) {
    _context.pushNamed(
      AppRoute.messages.name,
      extra: chat,
    );
  }

  void _chatListListener() {
    if (!_context.mounted) return;
    chats.value = _chatListProvider.chats;
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
