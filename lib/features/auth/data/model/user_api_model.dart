import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel {
  final int id;
  final String fullName;
  final String phone;
  final String token;

  UserApiModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.token,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return _$UserApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  UserApiModel copyWith() {
    return UserApiModel(
      id: id,
      fullName: fullName,
      phone: phone,
      token: token,
    );
  }
}
