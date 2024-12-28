import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';

class UpgradeScreenVm {
  final BuildContext _context;
  final ProfileRepository _profileRepository;

  UpgradeScreenVm(
    this._context,
    this._profileRepository,
  ) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);

  final pageController = PageController();

  List<PricingPlanApiModel> pricingPlans = [];

  void _init() {
    _initPaymentPlans();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();

    pageController.dispose();
  }

  Future<void> _initPaymentPlans() async {
    _setInitializing(true);
    try {
      final result = await _profileRepository.getPricingPlans();

      if (!_context.mounted) return;
      pricingPlans = result;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setInitializing(false);
  }

  // Future<void> sendFeedback() async {
  //   FocusScope.of(_context).unfocus();
  //
  //   final validForm = formKey.currentState?.validate();
  //   if (validForm == false) return;
  //
  //   _setLoading(true);
  //   try {
  //     await _profileRepository.sendFeedback(message);
  //
  //     _goFeedbackAccepted();
  //   } on Object catch (e, st) {
  //     LoggerService().e(error: e, stackTrace: st);
  //     _onError('$e');
  //   }
  //   _setLoading(false);
  // void _goFeedbackAccepted() {
  //   if (!_context.mounted) return;
  //   _context.goNamed(AppRoute.feedbackAccepted.name);
  // }
  // }

  void onContinue() {}

  void _setInitializing(bool value) {
    if (!_context.mounted) return;
    initializing.value = value;
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message, {bool isError = true}) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message, isError: isError);
  }
}
