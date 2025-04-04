import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/exception/logic_exception.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/chat/domain/use_case/send_message_use_case.dart';

typedef ErrorHandler = void Function(Object e, StackTrace st);

abstract interface class MessageListProvider with ChangeNotifier {
  List<MessageApiModel> get messages;

  int? get currentPage;

  Future<void> startChecking({
    required int chatId,
    ErrorHandler? onError,
  });

  void stopChecking();

  double? getScrollOffset(int chatId);

  void setScrollOffset(int chatId, double? value);

  Future<void> fetchPreviousPage({ErrorHandler? onError});

  Future<void> fetchNextPage({ErrorHandler onError});

  Future<List<MessageApiModel>> sendMessage(
    String text,
    List<File> attachmentFiles,
    RemoteFileType attachmentsType,
  );

  void clearCache();
}

class MessageListProviderImpl with ChangeNotifier implements MessageListProvider {
  final ChatRepository _chatRepository;
  final SendMessageUseCase _sendMessageUseCase;

  MessageListProviderImpl(
    this._chatRepository,
    this._sendMessageUseCase,
  );

  int? _chatId;
  int? _firstPageIndex;
  int? _currentPageIndex;
  int? _lastPageIndex;
  int? _maxPageIndex;
  List<MessageApiModel> _messages = [];
  Timer? _checkTimer;

  final Map<int, List<MessageApiModel>> _messageCache = {};
  final Map<int, double?> _scrollOffsetCache = {};

  @override
  List<MessageApiModel> get messages => List.unmodifiable(_messages);

  @override
  int? get currentPage => _currentPageIndex;

  @override
  Future<void> startChecking({
    required int chatId,
    ErrorHandler? onError,
  }) {
    stopChecking();

    _chatId = chatId;
    _checkTimer = Timer.periodic(
      Config.checkMessagesPeriod,
      (_) => _fetchMessagePage(),
    );

    _fillFromCache();

    return _fetchMessagePage(onError: onError);
  }

  @override
  void stopChecking() {
    _checkTimer?.cancel();
    _chatId = null;
    _firstPageIndex = null;
    _lastPageIndex = null;
    _maxPageIndex = null;
    _messages = [];
  }

  @override
  double? getScrollOffset(int chatId) {
    return _scrollOffsetCache[chatId];
  }

  @override
  void setScrollOffset(int chatId, double? value) {
    _scrollOffsetCache[chatId] = value;
  }

  @override
  Future<void> fetchPreviousPage({ErrorHandler? onError}) {
    final first = _firstPageIndex;
    if (first == null || first <= 1) return Future.value();

    return _fetchMessagePage(
      pageIndex: first - 1,
      onError: onError,
    );
  }

  @override
  Future<void> fetchNextPage({ErrorHandler? onError}) {
    final last = _lastPageIndex;
    final max = _maxPageIndex;
    if (last == null || max == null || last >= max) return Future.value();

    return _fetchMessagePage(
      pageIndex: last + 1,
      onError: onError,
    );
  }

  @override
  Future<List<MessageApiModel>> sendMessage(
    String text,
    List<File> attachments,
    RemoteFileType attachmentsType,
  ) async {
    final chatId = _chatId;
    if (chatId == null) throw LogicException('Chat checking is not started');

    return _sendMessageUseCase(chatId, text, attachments, attachmentsType);
  }

  @override
  void clearCache() {
    _messageCache.clear();
    _scrollOffsetCache.clear();
  }

  void _fillFromCache() {
    final fromCache = _messageCache[_chatId];
    if (fromCache != null) {
      _messages = fromCache;
      notifyListeners();
    }
  }

  Future<void> _fetchMessagePage({
    int? pageIndex,
    ErrorHandler? onError,
  }) async {
    final chatId = _chatId;
    if (chatId == null) {
      stopChecking();

      return;
    }

    try {
      final chatPage = await _chatRepository.getChatPage(chatId, index: pageIndex);
      final uniqueMessages = _messages.toSet();
      uniqueMessages.addAll(chatPage.messages);
      _messages = uniqueMessages.sorted((a, b) => a.id.compareTo(b.id));
      _updateMessagesCache();
      _updatePageIndexes(chatPage);
      debugPrint('first page: $_firstPageIndex');
      debugPrint('last page: $_lastPageIndex');
      debugPrint('max page: $_maxPageIndex');

      notifyListeners();
    } catch (e, st) {
      onError?.call(e, st);
    }
  }

  void _updateMessagesCache() {
    final chatId = _chatId;
    if (chatId == null) return;

    _messageCache[chatId] = _messages;
  }

  void _updatePageIndexes(ChatPageApiModel page) {
    _maxPageIndex = page.lastPageIndex;
    final current = page.pageIndex;
    _currentPageIndex = current;

    final first = _firstPageIndex;
    if (first == null || current < first) {
      _firstPageIndex = current;
    }

    final last = _lastPageIndex;
    if (last == null || current > last) {
      _lastPageIndex = current;
    }
  }
}
