// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApiModel _$ChatApiModelFromJson(Map<String, dynamic> json) => ChatApiModel(
      id: (json['id'] as num).toInt(),
      member: MemberApiModel.fromJson(json['member'] as Map<String, dynamic>),
      unreadCount: (json['unread_count'] as num).toInt(),
      lastMessage: json['last_message'] as String?,
    );

Map<String, dynamic> _$ChatApiModelToJson(ChatApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member': instance.member,
      'unread_count': instance.unreadCount,
      'last_message': instance.lastMessage,
    };
