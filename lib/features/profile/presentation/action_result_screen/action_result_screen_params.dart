import 'dart:ui';

class ActionResultScreenParams {
  final String title;
  final String description;
  final String? buttonLabel;
  final VoidCallback? onTap;

  ActionResultScreenParams({
    required this.title,
    required this.description,
    this.buttonLabel,
    this.onTap,
  });
}
