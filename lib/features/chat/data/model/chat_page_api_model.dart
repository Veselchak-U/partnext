import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

part 'chat_page_api_model.g.dart';

@JsonSerializable()
class ChatPageApiModel {
  final int chatId;
  final int index;
  final int lastIndex;
  final List<MessageApiModel> messages;

  ChatPageApiModel({
    required this.chatId,
    required this.index,
    required this.lastIndex,
    required this.messages,
  });

  factory ChatPageApiModel.fromJson(Map<String, dynamic> json) {
    return _$ChatPageApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatPageApiModelToJson(this);
}
