import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:partnext/env.dart';
import 'package:path_provider/path_provider.dart';

class Config {
  static const appName = 'Partnext';
  static const isProdBuild = bool.fromEnvironment('PROD_BUILD');
  static const termsAndConditionsUrl = 'https://partnext.tech/terms/';
  static const privacyPolicyUrl = 'https://partnext.tech/privacy/';

  static const paymentTimeoutDuration = Duration(minutes: 10);

  static const attachmentMaxSize = 100; //In megabytes
  static const attachmentAllowedFileExtensions = ['pdf'];

  static const checkChatsPeriod = Duration(minutes: 1);
  static const checkMessagesPeriod = Duration(seconds: 15);

  static const messageFileCacheStalePeriod = Duration(days: 30);

  static late final Env environment;

  static late final String? appDocFolder;
  static late final String? tempFolder;

  static Future<void> init({
    Env? savedEnv,
  }) async {
    environment = isProdBuild ? Env.prod : savedEnv ?? Env.dev;

    appDocFolder = await _getAppDocDirectory();
    tempFolder = await _getTempDirectory();
  }

  static Future<String?> _getAppDocDirectory() async {
    try {
      final appDocDirectory = await getApplicationDocumentsDirectory();
      await _createDirIfNotExist(appDocDirectory.path);

      return appDocDirectory.path;
    } on Object catch (e, st) {
      debugPrint('!!! Config.getAppDocDirectory(): $e, \n $st');

      return null;
    }
  }

  static Future<String?> _getTempDirectory() async {
    try {
      final tempDirectory = await getTemporaryDirectory();
      await _createDirIfNotExist(tempDirectory.path);

      return tempDirectory.path;
    } on Object catch (e, st) {
      debugPrint('!!! Config.getTempDirectory(): $e, \n $st');

      return null;
    }
  }

  static Future<void> _createDirIfNotExist(String dirPath) async {
    final dir = Directory(dirPath);
    final exist = await dir.exists();
    if (!exist) await dir.create(recursive: true);
  }
}
