import 'package:flutter/material.dart';
import 'package:partnext/common/overlays/app_overlays.dart';

class QuestionnaireScreenVm {
  final BuildContext _context;

  QuestionnaireScreenVm(
    this._context,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message);
  }
}
