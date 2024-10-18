import 'dart:convert';

import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  static final _levelPrefixes = {
    Level.trace: '[T]',
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
    Level.fatal: '[FATAL]',
  };

  static final _levelColors = {
    Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: const AnsiColor.none(),
    Level.info: const AnsiColor.fg(12),
    Level.warning: const AnsiColor.fg(208),
    Level.error: const AnsiColor.fg(196),
    Level.fatal: const AnsiColor.fg(199),
  };

  final bool printTime;
  final bool colors;

  AppLogPrinter({
    this.printTime = false,
    this.colors = true,
  });

  @override
  List<String> log(LogEvent event) {
    final messageStr = _stringifyMessage(event.message);
    final errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    var stackTrace = event.stackTrace;
    if (stackTrace == null && (event.level == Level.error || event.level == Level.fatal)) {
      stackTrace = StackTrace.current;
    }
    final stackTraceStr = _stringifyStackTrace(stackTrace);
    final timeStr = printTime ? 'TIME: ${event.time.toIso8601String()}' : '';

    final result = ['${_labelFor(event.level)} $timeStr $messageStr$errorStr'];
    if (stackTraceStr.isNotEmpty) result.add(stackTraceStr);

    return result;
  }

  String _labelFor(Level level) {
    var prefix = _levelPrefixes[level]!;
    var color = _levelColors[level]!;

    return colors ? color(prefix) : prefix;
  }

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = const JsonEncoder.withIndent(null);

      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  String _stringifyStackTrace(StackTrace? stackTrace) {
    if (stackTrace == null) return '';

    return 'STACK TRACE: $stackTrace';
  }
}
