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

  final pageController = PageController();

  final firstFormKey = GlobalKey<FormState>();

  void _init() {}

  void dispose() {
    loading.dispose();

    pageController.dispose();
  }

  void onNextPage() {}

  void _goNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  void goPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
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
