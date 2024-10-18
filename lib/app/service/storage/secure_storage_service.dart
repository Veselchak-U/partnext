import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:partnext/app/service/logger/logger_service.dart';

abstract interface class SecureStorageService {
  Future<String?> getString(String key);

  Future<void> setString(String key, String? value);

  Future<void> clear();
}

class SecureStorageServiceImpl implements SecureStorageService {
  SecureStorageServiceImpl() {
    _secureStorage = _getStorageInstance();
  }

  late final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> getString(String key) async {
    String? result;
    try {
      result = await _secureStorage.read(key: key);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
    }

    return result;
  }

  @override
  Future<void> setString(String key, String? value) async {
    try {
      if (value == null) {
        await _secureStorage.delete(key: key);
      } else {
        await _secureStorage.write(key: key, value: value);
      }
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
    }
  }

  FlutterSecureStorage _getStorageInstance() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    return FlutterSecureStorage(aOptions: getAndroidOptions());
  }

  @override
  Future<void> clear() async {
    try {
      await _secureStorage.deleteAll();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
    }
  }
}
