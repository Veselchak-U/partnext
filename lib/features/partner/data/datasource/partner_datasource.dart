import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

abstract interface class PartnerDatasource {
  Future<List<PartnerApiModel>> getRecommendations();

  Future<void> handleRecommendation(
    int userId, {
    required bool confirm,
  });

  Future<List<PartnerApiModel>> getPartners();

  Future<void> handlePartner(int userId, {required bool confirm});
}

class PartnerDatasourceImpl implements PartnerDatasource {
  final ApiClient _apiClient;

  PartnerDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<List<PartnerApiModel>> getRecommendations() {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.recommendations}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => PartnerApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> handleRecommendation(
    int userId, {
    required bool confirm,
  }) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.handleRecommendation}');

    return _apiClient.post(
      uri,
      body: {
        "user_id": userId,
        "confirm": confirm,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<List<PartnerApiModel>> getPartners() {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.partners}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => PartnerApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> handlePartner(int userId, {required bool confirm}) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.handlePartner}');

    return _apiClient.post(
      uri,
      body: {
        "user_id": userId,
        "confirm": confirm,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }
}
