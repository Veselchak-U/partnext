import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/dialogs/app_dialogs.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';
import 'package:partnext/features/profile/presentation/action_result_screen/action_result_screen_params.dart';

class UpgradeScreenVm {
  final BuildContext _context;
  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;
  final RefreshUserProfileUseCase _refreshUserProfileUseCase;

  UpgradeScreenVm(
    this._context,
    this._userRepository,
    this._profileRepository,
    this._refreshUserProfileUseCase,
  ) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);
  final selectedPlan = ValueNotifier<PricingPlanApiModel?>(null);

  final pageController = PageController();

  PricingPlanApiModel? currentPlan;
  List<PricingPlanApiModel> pricingPlans = [];
  String purchaseUrl = '';

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

  Future<void> onCancelCurrentPlan() async {
    final dialogResult = await AppDialogs.showSecondaryDialog(
      context: _context,
      title: _context.l10n.cancel_upgrade,
      description: _context.l10n.cancel_upgrade_desc,
      confirmLabel: _context.l10n.cancel_upgrade,
      cancelLabel: _context.l10n.keep_upgrading,
    );
    if (dialogResult != true) return;

    _setLoading(true);
    try {
      await _profileRepository.cancelPricingPlan();

      _onCancelSuccess();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _onCancelSuccess() {
    if (!_context.mounted) return;
    _context.goNamed(
      AppRoute.actionResult.name,
      extra: ActionResultScreenParams(
        title: _context.l10n.upgrade_was_canceled,
        description: _context.l10n.upgrade_was_canceled_desc,
      ),
    );
  }

  Future<void> onContinue() async {
    final newPlan = selectedPlan.value;
    if (newPlan == null) {
      _onError(_context.l10n.please_select_pricing_plan);

      return;
    }

    _goNextPage();
  }

  Future<void> onConfirmPurchase() async {
    final newPlan = selectedPlan.value;
    if (newPlan == null) {
      _onError(_context.l10n.please_select_pricing_plan);

      return;
    }

    _setLoading(true);
    try {
      //TODO: remove after test
      await _refreshUserProfileUseCase.call();
      //

      purchaseUrl = await _profileRepository.updatePricingPlan(newPlan.id);
      _goNextPage();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> onPurchaseSuccess() async {
    _setLoading(true);
    try {
      await _refreshUserProfileUseCase.call();

      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.actionResult.name,
        extra: ActionResultScreenParams(
          title: _context.l10n.thank_you,
          description: _context.l10n.lets_find_out_your_opportunities,
        ),
      );
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void onPurchaseTimeout() {
    _onError(_context.l10n.purchase_timeout);

    _goPreviousPage();
  }

  Future<void> _goNextPage() async {
    if (!_context.mounted) return;
    await pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  Future<void> _goPreviousPage() async {
    await pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
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
