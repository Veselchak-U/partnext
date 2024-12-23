import 'dart:io';

import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';

abstract interface class ProfileDatasource {
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final DioApiClient _dioApiClient;

  ProfileDatasourceImpl(
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
}
