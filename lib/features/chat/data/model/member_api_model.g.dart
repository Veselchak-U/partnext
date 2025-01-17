// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberApiModel _$MemberApiModelFromJson(Map<String, dynamic> json) =>
    MemberApiModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      photoUrl: json['photo_url'] as String,
    );

Map<String, dynamic> _$MemberApiModelToJson(MemberApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'photo_url': instance.photoUrl,
    };
