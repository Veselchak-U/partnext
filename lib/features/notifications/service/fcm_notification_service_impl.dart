import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/features/notifications/service/notification_service.dart';

class FcmNotificationServiceImpl extends NotificationService {
  static String? _fcmToken;

  static FirebaseMessaging get fcm => FirebaseMessaging.instance;

  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const _localNotificationsAndroidChannel = AndroidNotificationChannel(
    'partnext_app_notification_channel',
    'Partnext App Notifications',
    importance: Importance.max,
  );

  static Function(Map<dynamic, dynamic>, String?)? _handleMessageData;

  Future<bool> initFcm({
    required Function(Map<dynamic, dynamic>, String?) handleMessageData,
  }) async {
    _handleMessageData = handleMessageData;

    await updatePushToken();
    if (_fcmToken == null) {
      return false;
    }

    await fcm.requestPermission();
    await fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _initLocalNotificationsPlugin();
    _checkInitialMessage();
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    return true;
  }

  @override
  String? getPushToken() {
    LoggerService().d('FcmNotificationServiceImpl.getPushToken(): $_fcmToken');
    return _fcmToken;
  }

  @override
  Future<String?> updatePushToken() async {
    try {
      if (Platform.isIOS) {
        String? apnsToken = await fcm.getAPNSToken();
        if (apnsToken == null) {
          await Future<void>.delayed(const Duration(seconds: 3));
          apnsToken = await fcm.getAPNSToken();
        }
      }

      final result = await fcm.getToken();
      LoggerService().d('FcmNotificationServiceImpl.updatePushToken(): $result');
      _fcmToken = result;
      return result;
    } catch (err) {
      LoggerService().d('FcmNotificationServiceImpl.updatePushToken() error: $err');
      return null;
    }
  }

  @override
  Future<void> deletePushToken() async {
    try {
      await fcm.deleteToken();
      _fcmToken = null;
    } catch (err) {
      LoggerService().d('FcmNotificationServiceImpl.deletePushToken() error: $err');
    }
  }

  static Future<void> _initLocalNotificationsPlugin() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_push'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onLocalForegroundMessage,
    );
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_localNotificationsAndroidChannel);
    _checkInitialLocalMessage();
  }

  static void _checkInitialMessage() async {
    final initialMessage = await fcm.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  static void _checkInitialLocalMessage() async {
    final initialDetails = await _localNotificationsPlugin.getNotificationAppLaunchDetails();
    final isLaunchApp = initialDetails?.didNotificationLaunchApp;
    final response = initialDetails?.notificationResponse;
    if (isLaunchApp == true && response != null) {
      _onLocalMessageOpenedApp(response);
    }
  }

  static Future<void> _onForegroundMessage(RemoteMessage message) async {
    LoggerService().d('FcmNotificationServiceImpl.onForegroundMessage: $message');
    if (message.data.isNotEmpty) {
      _handleMessageData?.call(message.data, message.notification?.body);
    }
    if (message.notification?.android != null) {
      _createLocalAndroidNotification(message);
    }
  }

  static void _onLocalForegroundMessage(NotificationResponse response) {
    LoggerService().d('FcmNotificationServiceImpl.onLocalForegroundMessage: $response');
    final data = jsonDecode(response.payload ?? '{}') as Map<String, dynamic>;
    if (data.isNotEmpty) {
      _handleMessageData?.call(data, data["body"]);
    }
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    LoggerService().d('FcmNotificationServiceImpl.onMessageOpenedApp: $message');
    if (message.data.isNotEmpty) {
      _handleMessageData?.call(message.data, message.notification?.body);
    }
  }

  static void _onLocalMessageOpenedApp(NotificationResponse response) {
    LoggerService().d('FcmNotificationServiceImpl.onLocalMessageOpenedApp: $response');
    final data = jsonDecode(response.payload ?? '{}') as Map<String, dynamic>;
    if (data.isNotEmpty) {
      _handleMessageData?.call(data, null);
    }
  }

  static void _createLocalAndroidNotification(RemoteMessage message) {
    final notification = message.notification;
    final body = notification?.body?.replaceAll('\n', ' ');

    _localNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _localNotificationsAndroidChannel.id,
          _localNotificationsAndroidChannel.name,
          styleInformation: const BigTextStyleInformation(''),
        ),
      ),
      payload: jsonEncode({}),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  LoggerService().d('FcmNotificationServiceImpl._onBackgroundMessage: body = '
      '${message.notification?.body}, data = ${message.data}');
}
