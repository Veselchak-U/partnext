// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    MessageApiModel(
      id: (json['id'] as num).toInt(),
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      text: json['text'] as String,
    );

Map<String, dynamic> _$MessageApiModelToJson(MessageApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'text': instance.text,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.seen: 'seen',
};
