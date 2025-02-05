import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';

abstract interface class MessageListProvider with ChangeNotifier {
  List<MessageApiModel> get messages;

  Future<void> startChecking({
    required int chatId,
    Function(Object, StackTrace)? onError,
  });

  void stopChecking();
}

class MessageListProviderImpl with ChangeNotifier implements MessageListProvider {
  final ChatRepository _chatRepository;

  MessageListProviderImpl(
    this._chatRepository,
  );

  int? _chatId;
  List<MessageApiModel> _messages = [];
  Timer? _checkTimer;

  final Map<int, List<MessageApiModel>> _cache = {};

  @override
  List<MessageApiModel> get messages => List.unmodifiable(_messages);

  @override
  Future<void> startChecking({
    required int chatId,
    Function(Object, StackTrace)? onError,
  }) {
    _chatId = chatId;

    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(
      Config.checkMessagesPeriod,
      (_) => _refreshMessages(),
    );

    _fillFromCache();

    return _refreshMessages(onError: onError);
  }

  @override
  void stopChecking() {
    _checkTimer?.cancel();
    _chatId = null;
    _messages = [];
  }

  void _fillFromCache() {
    final fromCache = _cache[_chatId];
    if (fromCache != null) {
      _messages = fromCache;
      notifyListeners();
    }
  }

  void _updateCache() {
    final chatId = _chatId;
    if (chatId == null) return;

    _cache[chatId] = _messages;
  }

  Future<void> _refreshMessages({
    Function(Object, StackTrace)? onError,
  }) async {
    final chatId = _chatId;
    if (chatId == null) {
      stopChecking();

      return;
    }

    try {
      final chatPage = await _chatRepository.getChatPage(chatId);
      final uniqueMessages = _messages.toSet();
      uniqueMessages.addAll(chatPage.messages);
      _messages = uniqueMessages.sorted((a, b) => a.id.compareTo(b.id));
      _updateCache();

      notifyListeners();
    } catch (e, st) {
      onError?.call(e, st);
    }
  }
}
