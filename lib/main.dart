import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnext/app/app.dart';
import 'package:partnext/app/di.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/app/style/app_theme.dart';
import 'package:partnext/config.dart';

void main() {
  runZonedGuarded(
    _initializeApp,
    (e, st) {
      LoggerService().e(message: 'main.runZonedGuarded()', error: e, stackTrace: st);
      // if (!kDebugMode) FirebaseCrashlytics.instance.recordError(e, st, fatal: true);
    },
  );
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  FlutterError.onError = (details) {
    // if (!kDebugMode) FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    LoggerService().e(
      message: 'FlutterError.onError()',
      error: details.exception,
      stackTrace: details.stack ?? StackTrace.current,
    );
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (e, st) {
    // if (!kDebugMode) FirebaseCrashlytics.instance.recordError(e, st, fatal: true);
    LoggerService().e(message: 'PlatformDispatcher.onError()', error: e, stackTrace: st);

    return true;
  };

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    final error = errorAndStacktrace.first;
    final stackTrace = errorAndStacktrace.last;
    // if (!kDebugMode) await FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    LoggerService().e(message: 'Isolate.onError()', error: error, stackTrace: stackTrace);
  }).sendPort);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setSystemUIOverlayStyle(
    AppTheme.systemOverlayStyleLight,
  );

  DI().init();

  await Config.init();

  await LoggerService.init(toFile: true);

  // Controller.observer = StateControllerObserver();

  runApp(const App());
}
