import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';

abstract interface class ProfileDatasource {
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });

  Future<void> sendFeedback(String message);
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
}
