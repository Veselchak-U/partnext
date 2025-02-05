import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';

class MessageListScreenVm {
  final BuildContext _context;
  final MessageListProvider _messageListProvider;
  final ChatListProvider _chatListProvider;
  final ChatApiModel item;

  MessageListScreenVm(
    this._context,
    this._messageListProvider,
    this._chatListProvider, {
    required this.item,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final messages = ValueNotifier<List<MessageApiModel>?>(null);

  void _init() {
    _messageListProvider.addListener(__messageListListener);
    _refreshMessages();
  }

  void dispose() {
    _messageListProvider.removeListener(__messageListListener);
    _messageListProvider.stopChecking();

    loading.dispose();
    messages.dispose();
  }

  Future<void> _refreshMessages() async {
    _setLoading(true);
    await _messageListProvider.startChecking(
      chatId: item.id,
      onError: _handleError,
    );
    _setLoading(false);
  }

  void _handleError(Object e, StackTrace st) {
    LoggerService().e(error: e, stackTrace: st);
    _onError('$e');
  }

  void onRefresh() {
    _refreshMessages();
  }

  void onMessageTap(MessageApiModel message) {}

  void openContextMenu() {}

  void __messageListListener() {
    if (!_context.mounted) return;
    messages.value = _messageListProvider.messages;
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
