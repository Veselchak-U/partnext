import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/chat/domain/use_case/start_conversation_use_case.dart';

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
    RemoteFileType attachmentsType,
  );

  Future<void> markMessageAsRead({
    required int chatId,
    required MessageApiModel message,
  });
}

class ChatListProviderImpl with ChangeNotifier implements ChatListProvider {
  final ChatRepository _chatRepository;
  final StartConversationUseCase _startConversationUseCase;

  ChatListProviderImpl(
    this._chatRepository,
    this._startConversationUseCase,
  );

  List<ChatApiModel> _chats = [];
  Timer? _checkTimer;

  @override
  List<ChatApiModel> get chats => List.unmodifiable(_chats);

  @override
  int get unreadChatCount => _chats.where((e) => (e.unreadMessageCount ?? 0) != 0).length;

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
    RemoteFileType attachmentsType,
  ) async {
    final chat = await _startConversationUseCase(partnerId, text, attachments, attachmentsType);
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

  @override
  Future<void> markMessageAsRead({
    required int chatId,
    required MessageApiModel message,
  }) async {
    final chatIndex = _chats.indexWhere((e) => e.id == chatId);
    if (chatIndex == -1) return;

    final chat = _chats[chatIndex];
    final unreadMessageIndex = chat.unreadMessageIndex;
    if (unreadMessageIndex == null) return;

    if (message.index < unreadMessageIndex) return;

    final lastMessageIndex = chats[chatIndex].lastMessage?.index;
    if (lastMessageIndex == null) return;

    final newUnreadCount = lastMessageIndex - message.index;
    final updated = chat.copyWith(unreadMessageCount: newUnreadCount);
    _chats[chatIndex] = updated;
    notifyListeners();

    _chatRepository.markMessageAsRead(chatId: chatId, messageId: message.id);
  }
}
