extension IntExt on int? {
  String toFileSize() {
    final value = this;
    if (value == null) return '';

    if (value < 1024) return '$this B';

    if (value < 1024 * 1024) return '${(value / 1024).toStringAsFixed(1)} KB';

    return '${(value / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
