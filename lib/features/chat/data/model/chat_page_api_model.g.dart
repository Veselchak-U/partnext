// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_page_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPageApiModel _$ChatPageApiModelFromJson(Map<String, dynamic> json) =>
    ChatPageApiModel(
      chatId: (json['chat_id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      lastIndex: (json['last_index'] as num).toInt(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatPageApiModelToJson(ChatPageApiModel instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'index': instance.index,
      'last_index': instance.lastIndex,
      'messages': instance.messages,
    };
