import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:partnext/app/service/logger/printer/app_log_printer.dart';
import 'package:partnext/common/utils/date_time_ext.dart';
import 'package:partnext/config.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef GetAppInfoCallback = Future<String> Function();
typedef SendLogsCallback = Future<void> Function(List<File>, {bool toFirebase});

class LoggerService {
  static bool get isLogging => _saveToFile;

  static Logger? _logger;
  static late bool _saveToFile;
  static late bool _fromBackground;
  static SendLogsCallback? _onSendLogs;
  static String? _logFilePath;

  static Future<void> init({
    GetAppInfoCallback? getAppInfo,
    bool? toFile,
    bool? fromBackground,
    SendLogsCallback? onSendLogs,
    String? firebaseInitResult,
  }) async {
    // to complete previous record
    await Future.delayed(Duration.zero);

    _saveToFile = toFile ?? false;
    _fromBackground = fromBackground ?? false;
    _onSendLogs = onSendLogs;

    final logOutput = await _getLogOutput();
    _logger = Logger(
      filter: _MyFilter(),
      printer: AppLogPrinter(
        printTime: true,
        colors: false,
      ),
      output: logOutput,
    );

    _logger?.i('LoggerService.init(): firebaseInitResult = $firebaseInitResult');

    final appInfo = await getAppInfo?.call();
    _logger?.i(appInfo ?? 'AppInfo not defined');

    final logDir = await getLogFileDir();
    _logger?.i('\t environment: ${Config.environment} \n'
        '\t appDocFolder: ${Config.appDocFolder} \n'
        '\t logsFolder: ${logDir?.path}');

    if (!_fromBackground) {
      _sendLogsToRemoteStorage().then((_) => _deleteOldLogs());
    }
  }

  void d(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.d(message, error: error, stackTrace: stackTrace);
  }

  void i(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.i(message, error: error, stackTrace: stackTrace);
  }

  void w(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.w(message, error: error, stackTrace: stackTrace);
  }

  void e({Object? message, Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  // static Future<void> shareLogFiles() async {
  //   _sendLogsToRemoteStorage(toFirebase: true);
  //
  //   final logDir = await getLogFileDir();
  //   if (logDir == null) return;
  //
  //   if (Platform.isWindows) {
  //     _openDirectory(logDir.path);
  //
  //     return;
  //   }
  //
  //   final forShare = await logDir.list().where((e) => e.isLogFile(forShare: true)).map((e) => XFile(e.path)).toList();
  //
  //   final result = await Share.shareXFiles(forShare);
  //   _logger?.d('LoggerService.shareLogFiles(): ${result.status}');
  // }

  static void _openDirectory(String path) {
    Process.run(
      "explorer",
      [path],
      workingDirectory: path,
    );
  }

  static Future<LogOutput> _getLogOutput() async {
    if (_saveToFile) {
      if (_logFilePath == null) {
        _logFilePath = await _getLogFilePath(_fromBackground);
        debugPrint('!!! LoggerService._getLogOutput(): logFilePath = $_logFilePath');
      }

      return MultiOutput([
        ConsoleOutput(),
        if (_logFilePath != null)
          FileOutput(
            file: File(_logFilePath ?? ''),
            overrideExisting: _fromBackground ? false : true,
          ),
      ]);
    } else {
      _logFilePath = null;

      return ConsoleOutput();
    }
  }

  static Future<void> _sendLogsToRemoteStorage({
    bool toFirebase = false,
  }) async {
    final logDir = await getLogFileDir();
    if (logDir == null) return;

    final forSend = await logDir.list().where((e) => e.isLogFile(forShare: true)).toList();

    final files = forSend.map((e) => File(e.path)).toList();
    _onSendLogs?.call(files, toFirebase: toFirebase);
  }

  static Future<void> _deleteOldLogs() async {
    final logDir = await getLogFileDir();
    if (logDir == null) return;

    final forDelete = await logDir.list().where((e) => e.isLogFile(forDelete: true)).toList();

    for (var file in forDelete) {
      try {
        await file.delete();
        _logger?.d('LoggerService Deleted old log: ${file.path}');
      } catch (error) {
        _logger?.e('LoggerService Deleted old log: ${file.path}: $error');
      }
    }
  }

  static Future<String?> _getLogFilePath(bool isBackground) async {
    final logDir = await getLogFileDir();
    if (logDir == null) return null;

    final appName = Config.appName.toLowerCase();
    final fileDateTime = DateFormat('yyyy.MM.dd_HH-mm-ss').format(DateTime.now());
    final fileSuffix = isBackground ? '_bg' : '';
    final fileName = '${appName}_$fileDateTime$fileSuffix.log';

    return p.join(logDir.path, fileName);
  }

  static Future<Directory?> getLogFileDir() async {
    Directory? logDir;
    try {
      logDir = await getExternalStorageDirectory();
    } catch (err) {
      debugPrint('!!! getExternalStorageDirectory() error: $err');
    }

    final tempFolder = Config.tempFolder;
    if (logDir == null && tempFolder != null) {
      logDir = Directory(tempFolder);
    }

    return logDir;
  }
}

class _MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

extension _FileSystemEntityExt on FileSystemEntity {
  bool isLogFile({
    bool forShare = false,
    bool forDelete = false,
  }) {
    assert(forShare != forDelete, 'Exactly one parameter must be true');

    final fileStat = statSync();
    if (fileStat.type != FileSystemEntityType.file) return false;

    final fileName = p.basename(path);
    final fileNameMask = '${Config.appName.toLowerCase()}_';
    const fileExtMask = '.log';
    if (!fileName.startsWith(fileNameMask) || !fileName.endsWith(fileExtMask)) {
      return false;
    }

    final modifiedToday = fileStat.modified.isOnTheSameDay(DateTime.now());

    return forShare
        ? modifiedToday
        : forDelete
            ? !modifiedToday
            : false;
  }
}
