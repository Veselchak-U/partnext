import 'package:partnext/features/chat/data/model/chat_api_model.dart';

class MessageListScreenParams {
  final ChatApiModel? chat;
  final int? chatId;

  MessageListScreenParams({
    this.chat,
    this.chatId,
  });
}
