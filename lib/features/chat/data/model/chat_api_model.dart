import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel {
  final int id;
  final MemberApiModel member;
  final int unreadCount;
  final String? lastMessage;

  ChatApiModel({
    required this.id,
    required this.member,
    required this.unreadCount,
    required this.lastMessage,
  });

  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return _$ChatApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);
}
