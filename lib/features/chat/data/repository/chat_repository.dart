import 'dart:io';

import 'package:partnext/features/chat/data/datasource/chat_datasource.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';

abstract interface class ChatRepository {
  Future<List<ChatApiModel>> getChats();

  Future<ChatApiModel> createChat(int userId);

  Future<void> sendMessage(
    int chatId,
    String text,
    List<File> attachments,
  );

  Future<ChatPageApiModel> getChatPage(
    int chatId, {
    int? index,
  });

  Future<void> markMessageAsRead({
    required int chatId,
    required int messageId,
  });

  Future<void> reportMessage({
    required int chatId,
    required int messageId,
    required String description,
  });
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _chatDatasource;

  ChatRepositoryImpl(this._chatDatasource);

  @override
  Future<List<ChatApiModel>> getChats() {
    return _chatDatasource.getChats();
  }

  @override
  Future<ChatApiModel> createChat(int userId) {
    return _chatDatasource.createChat(userId);
  }

  @override
  Future<void> sendMessage(
    int chatId,
    String text,
    List<File> attachments,
  ) {
    return _chatDatasource.sendMessage(
      chatId,
      text,
      attachments,
    );
  }

  @override
  Future<ChatPageApiModel> getChatPage(
    int chatId, {
    int? index,
  }) {
    return _chatDatasource.getChatPage(chatId, index: index);
  }

  @override
  Future<void> markMessageAsRead({
    required int chatId,
    required int messageId,
  }) {
    return _chatDatasource.markMessageAsRead(
      chatId: chatId,
      messageId: messageId,
    );
  }

  @override
  Future<void> reportMessage({
    required int chatId,
    required int messageId,
    required String description,
  }) {
    return _chatDatasource.reportMessage(
      chatId: chatId,
      messageId: messageId,
      description: description,
    );
  }
}
