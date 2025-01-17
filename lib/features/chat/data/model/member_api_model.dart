import 'package:json_annotation/json_annotation.dart';

part 'member_api_model.g.dart';

@JsonSerializable()
class MemberApiModel {
  final int id;
  final String fullName;
  final String photoUrl;

  MemberApiModel({
    required this.id,
    required this.fullName,
    required this.photoUrl,
  });

  factory MemberApiModel.fromJson(Map<String, dynamic> json) {
    return _$MemberApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MemberApiModelToJson(this);
}
