import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel {
  final int id;
  final String fullName;
  final String position;
  final String phone;
  final String imageUrl;
  final PricingPlanApiModel? pricingPlan;
  final String token;

  UserApiModel({
    required this.id,
    required this.fullName,
    required this.position,
    required this.phone,
    required this.imageUrl,
    required this.pricingPlan,
    required this.token,
  });

  bool get isPro => pricingPlan != null;

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return _$UserApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}
