import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/domain/provider/chat_provider.dart';

class ChatListScreenVm {
  final BuildContext _context;
  final ChatProvider _chatProvider;

  ChatListScreenVm(
    this._context,
    this._chatProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final chats = ValueNotifier<List<ChatApiModel>?>(null);

  void _init() {
    _chatProvider.addListener(_chatProviderListener);
    _refreshChats();
  }

  void dispose() {
    _chatProvider.removeListener(_chatProviderListener);

    loading.dispose();
    chats.dispose();
  }

  Future<void> _refreshChats() async {
    _setLoading(true);
    await _chatProvider.refreshChats().onError(_handleError);
    _setLoading(false);
  }

  void _handleError(Object e, StackTrace st) {
    LoggerService().e(error: e, stackTrace: st);
    _onError('$e');
  }

  void onRefresh() {
    _refreshChats();
  }

  void _chatProviderListener() {
    if (!_context.mounted) return;
    chats.value = _chatProvider.chats;
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
