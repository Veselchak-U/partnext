import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/debouncer.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen_params.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MessageListScreenVm {
  final BuildContext _context;
  final MessageListProvider _messageListProvider;
  final ChatListProvider _chatListProvider;
  final FileRepository _fileRepository;
  final ChatApiModel chat;

  MessageListScreenVm(
    this._context,
    this._messageListProvider,
    this._chatListProvider,
    this._fileRepository, {
    required this.chat,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final messages = ValueNotifier<List<MessageApiModel>?>(null);
  final unreadMessageIndex = ValueNotifier<int?>(null);

  late final AutoScrollController autoScrollController;
  final _scrollDebouncer = Debouncer(milliseconds: 50);
  final _onMessageReadDebouncer = Debouncer(milliseconds: 1000);

  void _init() {
    final scrollOffset = _messageListProvider.getScrollOffset(chat.id) ?? 0;
    autoScrollController = AutoScrollController(initialScrollOffset: scrollOffset);
    autoScrollController.addListener(_saveScrollOffset);

    _messageListProvider.addListener(_messageListListener);
    _refreshMessages();

    _chatListProvider.addListener(_chatListListener);
    unreadMessageIndex.value = chat.unreadMessageIndex;
  }

  void dispose() {
    _messageListProvider.removeListener(_messageListListener);
    _messageListProvider.stopChecking();

    autoScrollController.removeListener(_saveScrollOffset);
    autoScrollController.dispose();

    _chatListProvider.removeListener(_chatListListener);

    loading.dispose();
    messages.dispose();
    unreadMessageIndex.dispose();
  }

  Future<void> _refreshMessages() async {
    _setLoading(true);
    await _messageListProvider.startChecking(
      chatId: chat.id,
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

  void onMessageTap(MessageApiModel item) {
    if (item.isImage) {
      _openImage(item);
    } else if (item.isDocument) {
      _openDocument(item);
    }
  }

  void _openImage(MessageApiModel item) {
    final url = item.attachment?.url;
    if (url == null) return;

    _context.pushNamed(
      AppRoute.viewImage.name,
      extra: ViewImageScreenParams(
        url: url,
        name: item.attachment?.name ?? '',
      ),
    );
  }

  Future<void> _openDocument(MessageApiModel item) async {
    final url = item.attachment?.url;
    if (url == null) return;

    _setLoading(true);
    try {
      final file = await _fileRepository.getFile(url);
      await OpenFile.open(file.path);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void openContextMenu() {}

  void onVisible(MessageApiModel message) {
    final isUnread = message.isUnread(unreadMessageIndex.value);
    if (!isUnread) return;

    _onMessageReadDebouncer.run(() {
      _chatListProvider.markMessageAsRead(
        chatId: chat.id,
        message: message,
      );
    });
  }

  void _messageListListener() {
    if (!_context.mounted) return;
    messages.value = _messageListProvider.messages;

    final scrollOffset = _messageListProvider.getScrollOffset(chat.id);
    final isFirstUpdate = scrollOffset == null;
    if (isFirstUpdate) {
      _scrollToUnreadMessage();
    }
  }

  Future<void> _scrollToUnreadMessage() async {
    final messageList = messages.value ?? [];

    final unreadMessageIndex = chat.unreadMessageIndex;
    if (unreadMessageIndex == null) return;

    final index = messageList.indexWhere((e) => e.index == unreadMessageIndex);
    if (index == -1) return;

    await autoScrollController.scrollToIndex(
      index,
      duration: Duration(milliseconds: 8),
      preferPosition: AutoScrollPosition.end,
    );

    _saveScrollOffset();
  }

  void _saveScrollOffset() {
    _scrollDebouncer.run(() {
      final scrollOffset = autoScrollController.offset;
      _messageListProvider.setScrollOffset(chat.id, scrollOffset);
    });
  }

  void _chatListListener() {
    final chats = _chatListProvider.chats;
    final currentChat = chats.firstWhereOrNull((e) => e.id == chat.id);
    if (currentChat == null) return;

    unreadMessageIndex.value = currentChat.unreadMessageIndex;
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
