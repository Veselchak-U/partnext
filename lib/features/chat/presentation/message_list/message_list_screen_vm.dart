import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen_params.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MessageListScreenVm {
  final BuildContext _context;
  final MessageListProvider _messageListProvider;
  final FileRepository _fileRepository;

  // final ChatListProvider _chatListProvider;
  final ChatApiModel item;

  MessageListScreenVm(
    this._context,
    this._messageListProvider,
    this._fileRepository,
    // this._chatListProvider,
    {
    required this.item,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final messages = ValueNotifier<List<MessageApiModel>?>(null);

  final scrollController = AutoScrollController();

  bool _isFirstMessageUpdate = true;

  void _init() {
    _messageListProvider.addListener(_messageListListener);
    _refreshMessages();
  }

  void dispose() {
    _messageListProvider.removeListener(_messageListListener);
    _messageListProvider.stopChecking();

    scrollController.dispose();

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

  void _messageListListener() {
    if (!_context.mounted) return;
    messages.value = _messageListProvider.messages;

    if (_isFirstMessageUpdate) {
      _scrollToUnreadMessage();
    }
  }

  void _scrollToUnreadMessage() {
    _isFirstMessageUpdate = false;

    final messageList = messages.value ?? [];

    final unreadMessageId = item.unreadMessage?.id;
    if (unreadMessageId == null) return;

    final unreadMessageIndex = messageList.indexWhere((e) => e.id == unreadMessageId);
    if (unreadMessageIndex == -1) return;

    scrollController.scrollToIndex(
      unreadMessageIndex,
      duration: Duration(milliseconds: 8),
      preferPosition: AutoScrollPosition.middle,
    );

    // Scrollable.ensureVisible(invalidFields.first.context);
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
