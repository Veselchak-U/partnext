// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentApiModel _$AttachmentApiModelFromJson(Map<String, dynamic> json) =>
    AttachmentApiModel(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AttachmentApiModelToJson(AttachmentApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
      'name': instance.name,
      'url': instance.url,
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.document: 'document',
};
