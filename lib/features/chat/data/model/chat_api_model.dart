import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel {
  final int id;
  final MemberApiModel member;
  @JsonKey(name: 'unread_message_index')
  final int? unreadMessageCount;
  final MessageApiModel? lastMessage;

  ChatApiModel({
    required this.id,
    required this.member,
    this.unreadMessageCount,
    this.lastMessage,
  });

  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return _$ChatApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);

  int? get unreadMessageIndex {
    final unreadCount = unreadMessageCount;
    if (unreadCount == null || unreadCount == 0) return null;

    final lastIndex = lastMessage?.index;
    if (lastIndex == null) return null;

    return lastIndex - unreadCount + 1;
  }

  String get lastMessageCreator {
    return (lastMessage?.creator.isCurrentUser ?? false) ? '${l10n?.you}: ' : '';
  }

  String get lastMessageDescription {
    return lastMessage?.description ?? '';
  }

  ChatApiModel copyWith({
    required int? unreadMessageCount,
  }) {
    return ChatApiModel(
      id: id,
      member: member,
      unreadMessageCount: unreadMessageCount,
      lastMessage: lastMessage,
    );
  }
}
