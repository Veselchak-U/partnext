// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'token': instance.token,
    };
