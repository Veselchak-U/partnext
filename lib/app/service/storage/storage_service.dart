import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StorageService {
  Future<String?> getString(String key);

  Future<void> setString(String key, String? value);

  Future<bool?> getBool(String key);

  Future<void> setBool(String key, bool? value);

  Future<void> clear();
}

class StorageServiceImpl implements StorageService {
  SharedPreferences? _sharedPrefs;

  @override
  Future<String?> getString(String key) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    return _sharedPrefs?.getString(key) ?? Future.value(null);
  }

  @override
  Future<void> setString(String key, String? value) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    return value == null
        ? _sharedPrefs?.remove(key) ?? Future.value(null)
        : _sharedPrefs?.setString(key, value) ?? Future.value(null);
  }

  @override
  Future<bool?> getBool(String key) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    return _sharedPrefs?.getBool(key) ?? Future.value(null);
  }

  @override
  Future<void> setBool(String key, bool? value) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    return value == null
        ? _sharedPrefs?.remove(key) ?? Future.value(null)
        : _sharedPrefs?.setBool(key, value) ?? Future.value(null);
  }

  @override
  Future<void> clear() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    try {
      await _sharedPrefs?.clear();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
    }
  }
}
