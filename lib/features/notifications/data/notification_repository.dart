import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/notifications/service/notification_service.dart';

abstract interface class NotificationRepository {
  Future<void> initPushService();

  String? getPushToken();

  Future<void> sendPushToken({
    required String? token,
    // required String lang,
  });
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;
  final ApiClient _apiClient;

  NotificationRepositoryImpl(
    this._notificationService,
    this._apiClient,
  );

  @override
  Future<void> initPushService() {
    if (_notificationService.initialized) return Future.value();

    return _notificationService.init();
  }

  @override
  String? getPushToken() {
    return _notificationService.getPushToken();
  }

  @override
  Future<void> sendPushToken({
    required String? token,
    // required String lang,
  }) async {
    if (token == null) return Future.value();

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.saveFcm}');

    return _apiClient.post(
      uri,
      body: {
        'fcm_token': token,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }
}
