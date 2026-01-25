import 'package:partnext/features/notifications/data/notification_repository.dart';

class SendPushTokenUseCase {
  final NotificationRepository _notificationRepository;

  SendPushTokenUseCase(
    this._notificationRepository,
  );

  Future<void> call() async {
    await _notificationRepository.initPushService();
    final token = _notificationRepository.getPushToken();
    await _notificationRepository.sendPushToken(token: token /*, lang: lang*/);
  }
}
