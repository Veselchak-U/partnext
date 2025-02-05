import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';

abstract interface class ChatListProvider with ChangeNotifier {
  List<ChatApiModel> get chats;

  int get unreadChatCount;

  Future<void> startChecking({
    Function(Object, StackTrace)? onError,
  });

  void stopChecking();

  Future<ChatApiModel> startConversation(
    int partnerId,
    String text,
    List<File> attachments,
  );
}

class ChatListProviderImpl with ChangeNotifier implements ChatListProvider {
  final ChatRepository _chatRepository;

  ChatListProviderImpl(
    this._chatRepository,
  );

  List<ChatApiModel> _chats = [];
  Timer? _checkTimer;

  @override
  List<ChatApiModel> get chats => List.unmodifiable(_chats);

  @override
  int get unreadChatCount => _chats.where((e) => e.unreadCount != 0).length;

  @override
  Future<void> startChecking({
    Function(Object, StackTrace)? onError,
  }) {
    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(
      Config.checkChatsPeriod,
      (_) => _refreshChats(),
    );

    return _refreshChats(onError: onError);
  }

  @override
  void stopChecking() {
    _checkTimer?.cancel();
  }

  @override
  Future<ChatApiModel> startConversation(
    int partnerId,
    String text,
    List<File> attachments,
  ) async {
    final chat = await _chatRepository.createChat(partnerId);
    await _chatRepository.sendMessage(chat.id, text, attachments);
    _refreshChats();

    return chat;
  }

  Future<void> _refreshChats({
    Function(Object, StackTrace)? onError,
  }) async {
    try {
      _chats = await _chatRepository.getChats();
      notifyListeners();
    } catch (e, st) {
      onError?.call(e, st);
    }
  }
}
