import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/utils/int_ext.dart';
import 'package:partnext/features/chat/domain/entity/attachment_type.dart';

part 'attachment_api_model.g.dart';

@JsonSerializable()
class AttachmentApiModel {
  final int? id;
  final AttachmentType type;
  final String? name;
  final String? url;
  final int? size;

  AttachmentApiModel({
    this.id,
    required this.type,
    this.name,
    this.url,
    this.size,
  });

  @override
  String toString() {
    final fileSize = size == null ? '' : '\n${size?.toFileSize()}';

    return switch (type) {
      AttachmentType.image => '${l10n?.image}: ${name ?? ''}$fileSize',
      AttachmentType.document => '${l10n?.document}: ${name ?? ''}$fileSize',
    };
  }

  factory AttachmentApiModel.fromJson(Map<String, dynamic> json) {
    return _$AttachmentApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttachmentApiModelToJson(this);
}
