import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/features/notifications/domain/use_case/navigate_from_push_use_case.dart';
import 'package:partnext/features/notifications/service/fcm_notification_service_impl.dart';

class NotificationService {
  static NotificationService? _instance;

  static late final NavigateFromPushUseCase _navigateFromPushUseCase;

  bool get initialized => _instance != null;

  Future<bool> init() async {
    final fcm = FcmNotificationServiceImpl();
    final fcmInitialized = await fcm.initFcm(
      handleMessageData: _handleMessageData,
    );
    if (fcmInitialized) {
      _instance = fcm;
      LoggerService().d('NotificationService.init(): Firebase');
      return true;
    }

    LoggerService().d('NotificationService.init(): none');
    return false;
  }

  String? getPushToken() {
    return _instance?.getPushToken();
  }

  Future<String?> updatePushToken() {
    return _instance?.updatePushToken() ?? Future.value(null);
  }

  Future<void> deletePushToken() {
    return _instance?.deletePushToken() ?? Future.value();
  }

  Future<void> _handleMessageData(
    Map<dynamic, dynamic> data,
    String? body,
  ) async {
    LoggerService().d('NotificationService.handleMessageData: data = $data, body = $body');
    final type = data["type"] as String?;
    switch (type) {
      case 'open_page':
        final path = data["path"] as String?;
        _navigateFromPushUseCase(path ?? '');
        break;
    }
  }
}
