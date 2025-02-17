import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

class ReportScreenParams {
  final ChatApiModel chat;
  final MessageApiModel message;

  ReportScreenParams({
    required this.chat,
    required this.message,
  });
}
