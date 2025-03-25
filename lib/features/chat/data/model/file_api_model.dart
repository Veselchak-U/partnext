import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/utils/int_ext.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';

part 'file_api_model.g.dart';

@JsonSerializable()
class FileApiModel {
  final int id;
  final RemoteFileType type;
  final String name;
  final String url;
  final int size;

  FileApiModel({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
    required this.size,
  });

  @override
  String toString() {
    final fileSize = '\n${size.toFileSize()}';

    return switch (type) {
      RemoteFileType.image => '${l10n?.image}: ${name ?? ''}$fileSize',
      RemoteFileType.document => '${l10n?.document}: ${name ?? ''}$fileSize',
    };
  }

  factory FileApiModel.fromJson(Map<String, dynamic> json) {
    return _$FileApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileApiModelToJson(this);
}
