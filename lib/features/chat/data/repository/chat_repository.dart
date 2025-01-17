import 'package:partnext/features/chat/data/datasource/chat_datasource.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';

abstract interface class ChatRepository {
  Future<ChatApiModel> createChat(int userId);

  Future<void> sendMessage(int chatId, String text);
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _chatDatasource;

  ChatRepositoryImpl(this._chatDatasource);

  @override
  Future<ChatApiModel> createChat(int userId) {
    return _chatDatasource.createChat(userId);
  }

  @override
  Future<void> sendMessage(int chatId, String text) {
    return _chatDatasource.sendMessage(chatId, text);
  }
}
