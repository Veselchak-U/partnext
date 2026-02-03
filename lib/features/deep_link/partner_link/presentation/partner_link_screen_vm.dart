import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../nav_bar/domain/provider/nav_bar_index_provider.dart';

class PartnerLinkScreenVm {
  final BuildContext _context;
  final NavBarIndexProvider _navBarIndexProvider;
  final PartnerRepository _partnerRepository;
  final int? partnerId;

  PartnerLinkScreenVm(
    this._context,
    this._navBarIndexProvider,
    this._partnerRepository, {
    required this.partnerId,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final recommendations = ValueNotifier<List<PartnerApiModel>?>(null);

  final swipableController = SwipableStackController();

  void _init() {
    _getPartner();
  }

  void dispose() {
    swipableController.dispose();

    loading.dispose();
    recommendations.dispose();
  }

  Future<void> _getPartner() async {
    final id = partnerId;
    if (id == null) {
      recommendations.value = [];
    } else {
      _setLoading(true);
      try {
        final result = await _partnerRepository.getPartnerById(id);

        if (!_context.mounted) return;
        recommendations.value = result == null ? [] : [result];
        swipableController.currentIndex = 0;
      } on Object catch (e, st) {
        LoggerService().e(error: e, stackTrace: st);
        _onError('$e');
      }
      _setLoading(false);
    }
  }

  Future<void> onRefresh() async {
    return _getPartner();
  }

  void onReject() {
    swipableController.next(swipeDirection: SwipeDirection.left);
  }

  void onApprove() {
    swipableController.next(swipeDirection: SwipeDirection.right);
  }

  Future<void> onSwipeCompleted(int index, SwipeDirection direction) async {
    await _handleRecommendation(
      index,
      confirm: direction == SwipeDirection.right,
    );

    if (!_context.mounted) return;
    goHome();
  }

  Future<void> _handleRecommendation(int index, {required bool confirm}) async {
    final recommendations = this.recommendations.value;
    if (recommendations == null || recommendations.isEmpty) {
      return;
    }

    _setLoading(true);
    try {
      final partner = recommendations[index];
      if (confirm && partner.isLikedMe == true) {
        _startChat(partner);
      }

      await _partnerRepository.handleRecommendation(partner.userId, confirm: confirm);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void goHome() {
    _setLoading(true);
    _navBarIndexProvider.navBarIndex = NavBarTab.home.index;

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.home.name,
      );
    });
  }

  void _startChat(PartnerApiModel partner) {
    _navBarIndexProvider.navBarIndex = NavBarTab.chats.index;

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.startChat.name,
        extra: partner,
      );
    });
  }

  void onOpenLink(String? url) {
    if (url == null) return;

    UrlLauncher.launchURL(url);
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
