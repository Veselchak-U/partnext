import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/auth/data/model/login_api_model.dart';

abstract interface class AuthDatasource {
  Future<void> register(String fullName, String phone);

  Future<void> requestOtp(String phone);

  Future<LoginApiModel> login(String phone, String code);
}

class AuthDatasourceImpl implements AuthDatasource {
  final ApiClient _apiClient;

  AuthDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<void> register(String fullName, String phone) {
    // return Future.delayed(Duration(seconds: 1));

    return _apiClient.post(
      Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.registration}'),
      body: {
        "full_name": fullName,
        "phone": phone,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.created) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> requestOtp(String phone) {
    // return Future.delayed(Duration(seconds: 1));

    return _apiClient.post(
      Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.requestOtp}'),
      body: {"phone": phone},
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<LoginApiModel> login(String phone, String code) async {
    // await Future.delayed(Duration(seconds: 1));
    //
    // return UserApiModel(
    //   id: -1,
    //   fullName: 'Eli Lavi',
    //   position: 'Co- Funder and CEO of Unaned',
    //   token: 'token',
    //   imageUrl:
    //       'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
    //   pricingPlan: null,
    //   // PricingPlanApiModel(
    //   //   id: 2,
    //   //   name: '3 Month',
    //   //   price: 69,
    //   //   priceTotal: 207,
    //   //   discount: 30,
    //   // ),
    // );

    return _apiClient.post(
      Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.checkOtp}'),
      body: {
        "phone": phone,
        "code": code,
      },
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return LoginApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }
}
