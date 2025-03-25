// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileApiModel _$FileApiModelFromJson(Map<String, dynamic> json) => FileApiModel(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$RemoteFileTypeEnumMap, json['type']),
      name: json['name'] as String,
      url: json['url'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$FileApiModelToJson(FileApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$RemoteFileTypeEnumMap[instance.type]!,
      'name': instance.name,
      'url': instance.url,
      'size': instance.size,
    };

const _$RemoteFileTypeEnumMap = {
  RemoteFileType.image: 'image',
  RemoteFileType.document: 'document',
};
