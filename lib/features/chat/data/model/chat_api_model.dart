import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel {
  final int id;
  final MemberApiModel member;
  final int unreadMessageIndex;
  final MessageApiModel? lastMessage;

  ChatApiModel({
    required this.id,
    required this.member,
    required this.unreadMessageIndex,
    this.lastMessage,
  });

  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return _$ChatApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);

  int get unreadMessageCount {
    final unreadIndex = unreadMessageIndex;
    if (unreadIndex == 0) return 0;

    final lastIndex = lastMessage?.index;
    if (lastIndex == null) return 0;

    return lastIndex - unreadIndex + 1;
  }

  String get lastMessageCreator {
    return (lastMessage?.creator.isCurrentUser ?? false) ? '${l10n?.you}: ' : '';
  }

  String get lastMessageDescription {
    return lastMessage?.description ?? '';
  }

  ChatApiModel copyWith({
    required int? unreadMessageIndex,
  }) {
    return ChatApiModel(
      id: id,
      member: member,
      unreadMessageIndex: unreadMessageIndex ?? this.unreadMessageIndex,
      lastMessage: lastMessage,
    );
  }
}
