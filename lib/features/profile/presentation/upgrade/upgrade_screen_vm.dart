import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';

class UpgradeScreenVm {
  final BuildContext _context;
  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;

  UpgradeScreenVm(
    this._context,
    this._userRepository,
    this._profileRepository,
  ) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);

  final pageController = PageController();

  PricingPlanApiModel? currentPlan;
  List<PricingPlanApiModel> pricingPlans = [];

  void _init() {
    _initPricingPlans();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();

    pageController.dispose();
  }

  Future<void> _initPricingPlans() async {
    _setInitializing(true);
    try {
      final results = await Future.wait([
        _userRepository.getUser(),
        _profileRepository.getPricingPlans(),
      ]);

      if (!_context.mounted) return;
      currentPlan = (results.first as UserApiModel?)?.pricingPlan;
      pricingPlans = results[1] as List<PricingPlanApiModel>;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setInitializing(false);
  }

  void onSelectPlan(PricingPlanApiModel plan) {}

  void onCancelCurrentPlan() {}

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
