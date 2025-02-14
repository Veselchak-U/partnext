import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';

typedef ErrorHandler = void Function(Object e, StackTrace st);

abstract interface class MessageListProvider with ChangeNotifier {
  List<MessageApiModel> get messages;

  Future<void> startChecking({
    required int chatId,
    ErrorHandler? onError,
  });

  void stopChecking();

  double? getScrollOffset(int chatId);

  void setScrollOffset(int chatId, double? value);

  Future<void> fetchPreviousPage({ErrorHandler? onError});

  Future<void> fetchNextPage({ErrorHandler onError});
}

class MessageListProviderImpl with ChangeNotifier implements MessageListProvider {
  final ChatRepository _chatRepository;

  MessageListProviderImpl(
    this._chatRepository,
  );

  int? _chatId;
  int? _firstPageIndex;
  int? _lastPageIndex;
  int? _maxPageIndex;
  List<MessageApiModel> _messages = [];
  Timer? _checkTimer;

  final Map<int, List<MessageApiModel>> _messageCache = {};
  final Map<int, double?> _scrollOffsetCache = {};

  @override
  List<MessageApiModel> get messages => List.unmodifiable(_messages);

  @override
  Future<void> startChecking({
    required int chatId,
    ErrorHandler? onError,
  }) {
    _chatId = chatId;

    _checkTimer?.cancel();
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
    if (first == null || first <= 0) return Future.value();

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
