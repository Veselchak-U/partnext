import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class GrowScreenVm {
  final BuildContext _context;
  final PartnersProvider _partnersProvider;
  final UserRepository _userRepository;
  final NavBarIndexProvider _navBarIndexProvider;

  GrowScreenVm(
    this._context,
    this._partnersProvider,
    this._userRepository,
    this._navBarIndexProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final hasPremium = ValueNotifier<bool>(false);
  final partners = ValueNotifier<List<PartnerApiModel>?>(null);

  //TODO: remove after testing
  bool _isFirstLoad = true;

  void _init() {
    _navBarIndexProvider.addListener(_navBarIndexProviderListener);
    _partnersProvider.addListener(_partnersProviderListener);
    _initUser();
    _refreshPartners();
  }

  void dispose() {
    _navBarIndexProvider.removeListener(_navBarIndexProviderListener);
    _partnersProvider.removeListener(_partnersProviderListener);

    loading.dispose();
    hasPremium.dispose();
    partners.dispose();
  }

  Future<void> _initUser() async {
    //TODO: remove after testing
    if (!_isFirstLoad) {
      hasPremium.value = true;

      return;
    }
    _isFirstLoad = false;

    try {
      final user = await _userRepository.getUser();
      hasPremium.value = user?.isPremium ?? false;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
  }

  Future<void> _refreshPartners() async {
    _setLoading(true);
    try {
      await _partnersProvider.refreshPartners();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void onRefresh() {
    _refreshPartners();
  }

  void openLink(String? profileUrl) {
    if (profileUrl == null) return;

    UrlLauncher.launchURL(profileUrl);
  }

  void onOpenPartnerDetails(PartnerApiModel item) {
    _context.pushNamed(
      AppRoute.partnerDetails.name,
      extra: item,
    );
  }

  Future<void> onApprove(PartnerApiModel partner) async {
    _setLoading(true);
    try {
      await _partnersProvider.approve(partner);
      _startChat(partner);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> onReject(PartnerApiModel partner) async {
    _setLoading(true);
    try {
      await _partnersProvider.reject(partner);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
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

  void goUpgradeScreen() {
    _navBarIndexProvider.navBarIndex = NavBarTab.profile.index;

    Future.delayed(Duration(milliseconds: 50)).then(
      (_) => _context.goNamed(AppRoute.upgrade.name),
    );
  }

  void _partnersProviderListener() {
    if (!_context.mounted) return;
    partners.value = _partnersProvider.partners;
  }

  void _navBarIndexProviderListener() {
    final navBarIndex = _navBarIndexProvider.navBarIndex;
    if (navBarIndex == NavBarTab.grow.index) {
      _initUser();
    }
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
