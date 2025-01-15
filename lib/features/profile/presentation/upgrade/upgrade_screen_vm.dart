import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final selectedPlan = ValueNotifier<PricingPlanApiModel?>(null);

  final pageController = PageController();

  PricingPlanApiModel? currentPlan;
  List<PricingPlanApiModel> pricingPlans = [];

  void _init() {
    _initPricingPlans();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();
    selectedPlan.dispose();

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

      if (currentPlan == null) {
        selectedPlan.value = pricingPlans.firstWhereOrNull((e) => e.isDefault == true);
      }
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setInitializing(false);
  }

  void onBackButtonPressed() {
    final currentPage = pageController.page?.round();
    if (currentPage == null) return;

    if (currentPage == 0) {
      _context.pop();
    } else {
      _goPreviousPage();
    }
  }

  void onSelectPlan(PricingPlanApiModel plan) {
    if (plan == selectedPlan.value) return;

    selectedPlan.value = plan;
  }

  void onCancelCurrentPlan() {}

  void onContinue() {
    final currentPage = pageController.page?.round();
    if (currentPage == null) return;

    final bool checkResult = switch (currentPage) {
      0 => _firstPageCheck(),
      _ => false,
    };
    if (!checkResult) return;

    _goNextPage();
  }

  bool _firstPageCheck() {
    return selectedPlan.value != null;
  }

  Future<void> _goNextPage() async {
    await pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
    // isLastPage.value = pageController.page == 5;
  }

  Future<void> _goPreviousPage() async {
    await pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
    // isLastPage.value = false;
  }

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
