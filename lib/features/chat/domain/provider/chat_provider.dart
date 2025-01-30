import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';

abstract interface class ChatProvider with ChangeNotifier {
  List<ChatApiModel> get chats;

  Future<void> refreshChats({
    Function(Object, StackTrace)? onError,
  });

  Future<ChatApiModel> startConversation(
    int partnerId,
    String text,
    List<File> attachments,
  );
}

class ChatProviderImpl with ChangeNotifier implements ChatProvider {
  final ChatRepository _chatRepository;

  ChatProviderImpl(
    this._chatRepository,
  );

  List<ChatApiModel> _chats = [];

  @override
  List<ChatApiModel> get chats => List.unmodifiable(_chats);

  @override
  Future<void> refreshChats({
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
  Future<ChatApiModel> startConversation(
    int partnerId,
    String text,
    List<File> attachments,
  ) async {
    final chat = await _chatRepository.createChat(partnerId);
    await _chatRepository.sendMessage(chat.id, text, attachments);
    refreshChats();

    return chat;
  }
}
