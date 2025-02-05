// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    MessageApiModel(
      id: (json['id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      creator: MemberApiModel.fromJson(json['creator'] as Map<String, dynamic>),
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      text: json['text'] as String?,
      attachment: json['attachment'] == null
          ? null
          : AttachmentApiModel.fromJson(
              json['attachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageApiModelToJson(MessageApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'created_at': instance.createdAt.toIso8601String(),
      'creator': instance.creator,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'text': instance.text,
      'attachment': instance.attachment,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.sent: 'sent',
  MessageStatus.seen: 'seen',
};
