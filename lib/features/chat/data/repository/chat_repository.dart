import 'package:partnext/features/chat/data/datasource/chat_datasource.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

abstract interface class ChatRepository {
  Future<List<ChatApiModel>> getChats();

  Future<ChatApiModel> createChat(int userId);

  Future<MessageApiModel> sendMessage(
    int chatId, {
    String? text,
    FileApiModel? attachment,
  });

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
    required String description,
    int? messageId,
  });

  Future<void> deleteChat(int chatId);
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
  Future<MessageApiModel> sendMessage(
    int chatId, {
    String? text,
    FileApiModel? attachment,
  }) {
    return _chatDatasource.sendMessage(
      chatId,
      text,
      attachment,
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
    required String description,
    int? messageId,
  }) {
    return _chatDatasource.reportMessage(
      chatId: chatId,
      description: description,
      messageId: messageId,
    );
  }

  @override
  Future<void> deleteChat(int chatId) {
    return _chatDatasource.deleteChat(chatId);
  }
}
