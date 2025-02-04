import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/chat/domain/entity/message_status.dart';

part 'message_api_model.g.dart';

@JsonSerializable()
class MessageApiModel {
  final int id;
  final MessageStatus status;
  final String text;

  MessageApiModel({
    required this.id,
    required this.status,
    required this.text,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageApiModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory MessageApiModel.fromJson(Map<String, dynamic> json) {
    return _$MessageApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageApiModelToJson(this);
}
