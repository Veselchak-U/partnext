// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plan_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingPlanApiModel _$PricingPlanApiModelFromJson(Map<String, dynamic> json) =>
    PricingPlanApiModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      priceTotal: (json['price_total'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toInt(),
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$PricingPlanApiModelToJson(
        PricingPlanApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'price_total': instance.priceTotal,
      'discount': instance.discount,
      'is_default': instance.isDefault,
    };
