import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/exception/logic_exception.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/debouncer.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/chat/presentation/message_list/widgets/message_menu.dart';
import 'package:partnext/features/chat/presentation/report/report_screen_params.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen_params.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MessageListScreenVm {
  final BuildContext _context;
  final MessageListProvider _messageListProvider;
  final ChatListProvider _chatListProvider;
  final FileRepository _fileRepository;
  final int chatId;

  MessageListScreenVm(
    this._context,
    this._messageListProvider,
    this._chatListProvider,
    this._fileRepository, {
    required this.chatId,
  }) {
    _init();
  }

  final initialized = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);
  final chat = ValueNotifier<ChatApiModel?>(null);
  final messages = ValueNotifier<List<MessageApiModel>?>(null);
  final unreadMessageIndex = ValueNotifier<int?>(null);
  final previousPageLoading = ValueNotifier<bool>(false);
  final nextPageLoading = ValueNotifier<bool>(false);

  late final AutoScrollController autoScrollController;
  final _scrollDebouncer = Debouncer(milliseconds: 50);
  final _onMessageReadDebouncer = Debouncer(milliseconds: 1000);

  bool _isFirstUpdate = true;

  Future<void> _init() async {
    _setLoading(true);
    await _initChat();
    await _initMessages();
    initialized.value = true;
    _setLoading(false);
  }

  void dispose() {
    _messageListProvider.removeListener(_messageListListener);
    _messageListProvider.stopChecking();

    autoScrollController.removeListener(_scrollListener);
    autoScrollController.dispose();

    _chatListProvider.removeListener(_chatListListener);

    initialized.dispose();
    loading.dispose();
    chat.dispose();
    messages.dispose();
    unreadMessageIndex.dispose();
    previousPageLoading.dispose();
    nextPageLoading.dispose();
  }

  Future<void> _initChat() async {
    // Get chat from cache
    ChatApiModel? cachedChat = _chatListProvider.chats.firstWhereOrNull((e) => e.id == chatId);
    if (cachedChat != null) {
      chat.value = cachedChat;

      return;
    }

    // If it is not in cache - refresh chats from server
    await _chatListProvider.startChecking(
      onError: _handleError,
    );

    // Get chat from cache after refresh
    cachedChat = _chatListProvider.chats.firstWhereOrNull((e) => e.id == chatId);
    if (cachedChat != null) {
      chat.value = cachedChat;

      return;
    }

    _onError('${LogicException('Chat id=$chatId not found')}');
  }

  Future<void> _initMessages() async {
    if (chat.value == null) return;

    // final scrollOffset = _messageListProvider.getScrollOffset(chatId) ?? 0;
    autoScrollController = AutoScrollController(/*initialScrollOffset: scrollOffset*/);
    autoScrollController.addListener(_scrollListener);

    _messageListProvider.addListener(_messageListListener);
    _startMessagesChecking();

    _chatListProvider.addListener(_chatListListener);
    unreadMessageIndex.value = chat.value?.unreadMessageIndex;
  }

  Future<void> _startMessagesChecking() async {
    _setLoading(true);
    await _messageListProvider.startChecking(
      chatId: chatId,
      onError: _handleError,
    );
    _setLoading(false);
  }

  void _handleError(Object e, StackTrace st) {
    LoggerService().e(error: e, stackTrace: st);
    _onError('$e');
  }

  void refreshCurrentPage() {
    _messageListProvider.refreshCurrentPage();
  }

  void onMessageTap(MessageApiModel item) {
    if (item.isImage) {
      _openImage(item);
    } else {
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

  void openChatMenu() {}

  void openMessageMenu(MessageApiModel message) {
    final currentChat = chat.value;
    if (currentChat == null) return;

    showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      builder: (context) {
        return MessageMenu(
          onReport: () => _openReportScreen(currentChat, message),
        );
      },
    );
  }

  void _openReportScreen(ChatApiModel chat, MessageApiModel message) {
    _context.pushNamed(
      AppRoute.report.name,
      extra: ReportScreenParams(chat: chat, message: message),
    );
  }

  void onVisible(MessageApiModel message) {
    final isUnread = message.isUnread(unreadMessageIndex.value);
    if (!isUnread) return;

    _onMessageReadDebouncer.run(() {
      _chatListProvider.markMessageAsRead(
        chatId: chatId,
        message: message,
      );
    });
  }

  Future<void> getPreviousPage() async {
    previousPageLoading.value = true;
    await _messageListProvider.fetchPreviousPage(
      onError: _handleError,
    );
    previousPageLoading.value = false;
  }

  Future<void> getNextPage() async {
    nextPageLoading.value = true;
    await _messageListProvider.fetchNextPage(
      onError: _handleError,
    );
    nextPageLoading.value = false;
  }

  Future<void> onSendMessage(
    String text,
    List<File> attachmentFiles,
    RemoteFileType attachmentsType,
  ) async {
    _setLoading(true);
    try {
      await _messageListProvider.sendMessage(text, attachmentFiles, attachmentsType);

      refreshCurrentPage();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _messageListListener() {
    if (!_context.mounted) return;
    messages.value = _messageListProvider.messages;

    // final scrollOffset = _messageListProvider.getScrollOffset(chatId);
    // final isFirstUpdate = scrollOffset == null;
    if (_isFirstUpdate) {
      _isFirstUpdate = false;
      _scrollToUnreadMessage();
    }
  }

  Future<void> _scrollToUnreadMessage() async {
    final messageList = messages.value ?? [];

    final unreadMessageIndex = chat.value?.unreadMessageIndex;
    if (unreadMessageIndex == null) return;

    final index = messageList.indexWhere((e) => e.index == unreadMessageIndex);
    if (index == -1) {
      _scrollToLastMessage();

      return;
    }

    await autoScrollController.scrollToIndex(
      index,
      duration: Duration(milliseconds: 8),
      preferPosition: AutoScrollPosition.end,
    );

    // _saveScrollOffset();
  }

  Future<void> _scrollToLastMessage() async {
    final messageList = messages.value ?? [];
    if (messageList.isEmpty) return;

    final index = messageList.last.index;
    await autoScrollController.scrollToIndex(
      index,
      duration: Duration(milliseconds: 8),
      preferPosition: AutoScrollPosition.end,
    );

    // _saveScrollOffset();
  }

  void _scrollListener() {
    // _saveScrollOffset();
    _fetchNearestPage();
  }

  // void _saveScrollOffset() {
  //   _scrollDebouncer.run(() {
  //     final scrollOffset = autoScrollController.offset;
  //     _messageListProvider.setScrollOffset(chatId, scrollOffset);
  //   });
  // }

  void _fetchNearestPage() {
    final scrollOffset = autoScrollController.offset;
    final maxScrollExtent = autoScrollController.position.maxScrollExtent;

    if (scrollOffset == 0) {
      getPreviousPage();
    }

    if (scrollOffset == maxScrollExtent) {
      getNextPage();
    }
  }

  void _chatListListener() {
    final chats = _chatListProvider.chats;
    final currentChat = chats.firstWhereOrNull((e) => e.id == chatId);
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
