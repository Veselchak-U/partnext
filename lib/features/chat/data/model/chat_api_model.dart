import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel {
  final int id;
  final MemberApiModel member;
  final MessageApiModel? unreadMessage;
  final MessageApiModel? lastMessage;

  ChatApiModel({
    required this.id,
    required this.member,
    required this.unreadMessage,
    required this.lastMessage,
  });

  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return _$ChatApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);

  int get unreadCount {
    final lastIndex = lastMessage?.index;
    final unreadIndex = unreadMessage?.index;
    if (lastIndex == null || unreadIndex == null) return 0;

    return lastIndex - unreadIndex + 1;
  }

  String get lastMessageDescription {
    return lastMessage?.description ?? '';
  }
}
