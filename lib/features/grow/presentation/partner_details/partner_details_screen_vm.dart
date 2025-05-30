import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class PartnerDetailsScreenVm {
  final BuildContext _context;
  final PartnersProvider _partnersProvider;
  final NavBarIndexProvider _navBarIndexProvider;
  final PartnerApiModel partner;

  PartnerDetailsScreenVm(
    this._context,
    this._partnersProvider,
    this._navBarIndexProvider, {
    required this.partner,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  void _init() {}

  void dispose() {
    loading.dispose();
  }

  void openLink(String? profileUrl) {
    if (profileUrl == null) return;

    UrlLauncher.launchURL(profileUrl);
  }

  Future<void> onApprove() async {
    _setLoading(true);
    try {
      await _partnersProvider.approve(partner);
      _startChat();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> onReject() async {
    _setLoading(true);
    try {
      await _partnersProvider.reject(partner);
      _goBack();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _startChat() {
    _navBarIndexProvider.navBarIndex = NavBarTab.chats.index;

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      if (!_context.mounted) return;
      _context.goNamed(
        AppRoute.startChat.name,
        extra: partner,
      );
    });
  }

  void _goBack() {
    if (!_context.mounted) return;
    _context.pop();
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
