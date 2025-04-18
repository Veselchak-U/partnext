import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

abstract interface class ProfileDatasource {
  Future<UserApiModel> getUserProfile();

  Future<void> updateUserAvatar(String imageUrl);

  Future<void> sendFeedback(String message);

  Future<List<PricingPlanApiModel>> getPricingPlans();

  Future<String> updatePricingPlan(int planId);

  Future<void> cancelPricingPlan();

  Future<void> deleteUserProfile();
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final ApiClient _apiClient;

  ProfileDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<UserApiModel> getUserProfile() async {
    // await Future.delayed(const Duration(seconds: 1));
    //
    // return _mockedUser;

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.userProfile}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return UserApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> updateUserAvatar(String imageUrl) {
    // return Future.delayed(const Duration(seconds: 1));

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.userProfile}');

    return _apiClient.post(
      uri,
      body: {
        "image_url": imageUrl,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> sendFeedback(String message) {
    // return Future.delayed(const Duration(seconds: 1));

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendFeedback}');

    return _apiClient.post(
      uri,
      body: {
        "message": message,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<List<PricingPlanApiModel>> getPricingPlans() async {
    // await Future.delayed(const Duration(seconds: 1));
    //
    // return _mockedPaymentPlans;

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.pricingPlans}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => PricingPlanApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<String> updatePricingPlan(int planId) async {
    await Future.delayed(const Duration(seconds: 1));

    return 'https://www.google.com';

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.updatePlan}');
    //
    // return _apiClient.post(
    //   uri,
    //   body: {
    //     "plan_id": planId,
    //   },
    //   parser: (response) {
    //     if (response.body case final Map<String, dynamic> body) {
    //       final iframeUrl = body['iframe_url'] as String?;
    //
    //       if (iframeUrl == null) throw ApiException(response);
    //
    //       return iframeUrl;
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  @override
  Future<void> cancelPricingPlan() async {
    // await Future.delayed(const Duration(seconds: 1));
    //
    // return;

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.cancelPlan}');

    return _apiClient.post(
      uri,
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> deleteUserProfile() {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.userProfile}');

    return _apiClient.delete(
      uri,
      parser: (response) {
        if (response.statusCode == HttpStatus.noContent) return;

        throw ApiException(response);
      },
    );
  }
}

// final _mockedUser = UserApiModel(
//   id: -1,
//   fullName: 'Eli Lavi',
//   position: 'Co- Funder and CEO of Unaned',
//   // phone: '+79281234567',
//   token: 'token',
//   imageUrl:
//       'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
//   pricingPlan: PricingPlanApiModel(
//     id: 2,
//     name: '3 Month',
//     price: 69,
//     priceTotal: 207,
//     discount: 30,
//   ),
// );
//
// final _mockedPaymentPlans = [
//   PricingPlanApiModel(
//     id: 0,
//     name: '1 Week',
//     price: 29,
//     priceTotal: 29,
//   ),
//   PricingPlanApiModel(
//     id: 1,
//     name: '1 Month',
//     price: 99,
//     priceTotal: 99,
//     isDefault: true,
//   ),
//   PricingPlanApiModel(
//     id: 2,
//     name: '3 Month',
//     price: 69,
//     priceTotal: 207,
//     discount: 30,
//   ),
//   PricingPlanApiModel(
//     id: 3,
//     name: '6 Month',
//     price: 49,
//     priceTotal: 294,
//     discount: 50,
//   ),
// ];
