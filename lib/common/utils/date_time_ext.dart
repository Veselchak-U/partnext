import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

extension DateTimeExt on DateTime? {
  bool isOnTheSameDay(DateTime other) {
    return this?.year == other.year && this?.month == other.month && this?.day == other.day;
  }

  String get longDate {
    final date = this;
    if (date == null) return '';

    return DateFormat('dd.MM.yyyy').format(date);
  }

  String toServerFormat() {
    final date = this;
    if (date == null) return '';

    return DateFormat('dd.MM.yyyy').format(date).toString();
  }

  String timeShort() {
    final date = this;
    if (date == null) return '';

    return DateFormat('hh:mm aaa').format(date).toString();
  }
}

class ConvertDateTime implements JsonConverter<DateTime?, String?> {
  const ConvertDateTime();

  @override
  DateTime? fromJson(String? value) {
    if (value == null) return null;

    // return value.toDate();

    return DateTime.tryParse(value)?.toLocal();
  }

  @override
  String? toJson(DateTime? value) {
    if (value == null) return null;

    // return DateFormat('dd.MM.yyyy').format(value);

    return value.toUtc().toIso8601String();
  }
}

extension DurationExt on Duration? {
  String toCountDown() {
    final duration = this;
    if (duration == null) return '';

    final date = DateTime(0).add(duration);

    return DateFormat('mm:ss').format(date).toString();
  }
}
