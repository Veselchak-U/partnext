import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/chat/data/model/attachment_api_model.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/domain/entity/attachment_type.dart';
import 'package:partnext/features/chat/domain/entity/message_status.dart';

part 'message_api_model.g.dart';

@JsonSerializable()
class MessageApiModel {
  final int id;
  final int index;
  final DateTime createdAt;
  final MemberApiModel creator;
  final MessageStatus status;
  final String? text;
  final AttachmentApiModel? attachment;

  MessageApiModel({
    required this.id,
    required this.index,
    required this.createdAt,
    required this.creator,
    required this.status,
    this.text,
    this.attachment,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageApiModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory MessageApiModel.fromJson(Map<String, dynamic> json) {
    return _$MessageApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageApiModelToJson(this);

  bool get isUnread => status != MessageStatus.seen;

  bool get isImage => attachment?.type == AttachmentType.image;

  String get description {
    if (text != null) {
      return text ?? '';
    }

    return '$attachment';
  }
}
