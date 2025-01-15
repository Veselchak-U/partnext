import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

abstract interface class ProfileDatasource {
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });

  Future<void> sendFeedback(String message);

  Future<List<PricingPlanApiModel>> getPricingPlans();
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final ApiClient _apiClient;
  final DioApiClient _dioApiClient;

  ProfileDatasourceImpl(
    this._apiClient,
    this._dioApiClient,
  );

  @override
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  }) {
    return Future.delayed(const Duration(seconds: 1));

    // return _dioApiClient.uploadFiles(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.userAvatar}'),
    //   [file],
    //   onSendProgress: onSendProgress,
    // );
  }

  @override
  Future<void> sendFeedback(String message) {
    return Future.delayed(const Duration(seconds: 1));

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendFeedback}');
    //
    // return _apiClient.post(
    //   uri,
    //   body: {
    //     "message": message,
    //   },
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.ok) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  @override
  Future<List<PricingPlanApiModel>> getPricingPlans() async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockedPaymentPlans;

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.paymentPlans}');
    //
    // return _apiClient.get(
    //   uri,
    //   parser: (response) {
    //     if (response.body case final List? body) {
    //       if (body == null || body.isEmpty) return [];
    //
    //       final result = body.map((e) => PaymentPlanApiModel.fromJson(e)).toList();
    //
    //       return result;
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  final _mockedPaymentPlans = [
    PricingPlanApiModel(
      id: 0,
      name: '1 Week',
      price: 29,
      priceTotal: 29,
    ),
    PricingPlanApiModel(
      id: 1,
      name: '1 Month',
      price: 99,
      priceTotal: 99,
      isDefault: true,
    ),
    PricingPlanApiModel(
      id: 2,
      name: '3 Month',
      price: 69,
      priceTotal: 207,
      discount: 30,
    ),
    PricingPlanApiModel(
      id: 3,
      name: '6 Month',
      price: 49,
      priceTotal: 294,
      discount: 50,
    ),
  ];
}
