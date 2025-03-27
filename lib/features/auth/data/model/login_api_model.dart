import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

part 'login_api_model.g.dart';

@JsonSerializable()
class LoginApiModel {
  final int userId;
  final String fullName;
  final String? position;
  final String? imageUrl;
  final PricingPlanApiModel? pricingPlan;
  final String token;

  LoginApiModel({
    required this.userId,
    required this.fullName,
    required this.position,
    required this.imageUrl,
    required this.pricingPlan,
    required this.token,
  });

  factory LoginApiModel.fromJson(Map<String, dynamic> json) {
    return _$LoginApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginApiModelToJson(this);

  UserApiModel get user => UserApiModel(
        userId: userId,
        fullName: fullName,
        position: position,
        imageUrl: imageUrl,
        pricingPlan: pricingPlan,
      );
}
