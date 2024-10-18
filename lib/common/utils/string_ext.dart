import 'package:flutter/material.dart';

extension StringExt on String? {
  String removeLeadingSymbols(String pattern) {
    String result = this ?? '';

    while (result.startsWith(pattern)) {
      result = result.characters.getRange(pattern.length).toString();
    }

    return result;
  }

  DateTime? toDate() {
    final dateString = this;
    if (dateString == null) return null;

    final split = dateString.split('.');
    if (split.length != 3) return null;

    final day = int.tryParse(split[0]);
    final month = int.tryParse(split[1]);
    final year = int.tryParse(split[2]);
    if (day == null || month == null || year == null) return null;

    return DateTime(year, month, day);
  }

  TimeOfDay? toTime() {
    final timeString = this;
    if (timeString == null) return null;

    final split = timeString.split(':');
    if (split.length != 2) return null;

    final hours = int.tryParse(split[0]);
    final minutes = int.tryParse(split[1]);
    if (hours == null || minutes == null) return null;

    return TimeOfDay(hour: hours, minute: minutes);
  }
}
