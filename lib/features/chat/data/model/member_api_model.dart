import 'package:json_annotation/json_annotation.dart';

part 'member_api_model.g.dart';

@JsonSerializable()
class MemberApiModel {
  final int userId;
  final String fullName;
  final String? photoUrl;
  final bool? isCurrentUser;

  MemberApiModel({
    required this.userId,
    required this.fullName,
    required this.photoUrl,
    this.isCurrentUser,
  });

  factory MemberApiModel.fromJson(Map<String, dynamic> json) {
    return _$MemberApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MemberApiModelToJson(this);
}
