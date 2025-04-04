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
  int? _startPageIndex;
  int? _endPageIndex;
  int? _maxPageIndex;
  List<MessageApiModel> _messages = [];
  Timer? _checkTimer;

  final Map<int, List<MessageApiModel>> _messageCache = {};
  final Map<int, double?> _scrollOffsetCache = {};
  final Map<int, (int? start, int? end, int? max)> _pageIndexCache = {};

  @override
  List<MessageApiModel> get messages => List.unmodifiable(_messages);

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
    _startPageIndex = null;
    _endPageIndex = null;
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
    final start = _startPageIndex;
    if (start == null || start <= 1) return Future.value();

    return _fetchMessagePage(
      pageIndex: start - 1,
      onError: onError,
    );
  }

  @override
  Future<void> fetchNextPage({ErrorHandler? onError}) {
    final end = _endPageIndex;
    final max = _maxPageIndex;
    if (end == null || max == null || end >= max) return Future.value();

    return _fetchMessagePage(
      pageIndex: end + 1,
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
    _pageIndexCache.clear();
  }

  void _fillFromCache() {
    final fromCache = _messageCache[_chatId];
    if (fromCache != null) {
      _messages = fromCache;

      final indexes = _pageIndexCache[_chatId];
      _startPageIndex = indexes?.$1;
      _endPageIndex = indexes?.$2;
      _maxPageIndex = indexes?.$3;

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
      _updatePageIndexes(chatId, chatPage);
      debugPrint('!!! start page: $_startPageIndex');
      debugPrint('!!! end page: $_endPageIndex');
      debugPrint('!!! max page: $_maxPageIndex');

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

  void _updatePageIndexes(int chatId, ChatPageApiModel page) {
    _maxPageIndex = page.lastPageIndex;
    final current = page.pageIndex;

    final start = _startPageIndex;
    if (start == null || current < start) {
      _startPageIndex = current;
    }

    final end = _endPageIndex;
    if (end == null || current > end) {
      _endPageIndex = current;
    }

    _pageIndexCache[chatId] = (_startPageIndex, _endPageIndex, _maxPageIndex);
  }
}
