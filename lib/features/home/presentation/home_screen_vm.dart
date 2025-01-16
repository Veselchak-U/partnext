import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreenVm {
  final BuildContext _context;
  final PartnerRepository _partnerRepository;

  HomeScreenVm(
    this._context,
    this._partnerRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final recommendations = ValueNotifier<List<PartnerApiModel>?>(null);

  final swipableController = SwipableStackController();

  bool isTooManySwipes = false;

  void _init() {
    getRecommendations();
  }

  void dispose() {
    swipableController.dispose();

    loading.dispose();
    recommendations.dispose();
  }

  Future<void> getRecommendations() async {
    _setLoading(true);
    try {
      final result = await _partnerRepository.getRecommendations();

      if (!_context.mounted) return;
      recommendations.value = result;
      swipableController.currentIndex = 0;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void onRefresh() {
    getRecommendations();
  }

  Future<void> onSwipeCompleted(int index, SwipeDirection direction) async {
    _handleRecommendation(
      index,
      confirm: direction == SwipeDirection.right,
    );

    if (!_context.mounted) return;
    final isLast = index == (recommendations.value?.length ?? 0) - 1;
    if (isLast) {
      isTooManySwipes = true;
      recommendations.value = [];
    }
  }

  Future<void> _handleRecommendation(int index, {required bool confirm}) async {
    final recommendation = recommendations.value?[index];
    if (recommendation == null) return;

    // _setLoading(true);
    try {
      await _partnerRepository.handleRecommendation(recommendation.id, confirm: confirm);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    // _setLoading(false);
  }

  void openLink(String? profileUrl) {
    if (profileUrl == null) return;

    UrlLauncher.launchURL(profileUrl);
  }

  void onReject() {
    swipableController.next(swipeDirection: SwipeDirection.left);
  }

  void onApprove() {
    swipableController.next(swipeDirection: SwipeDirection.right);
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
