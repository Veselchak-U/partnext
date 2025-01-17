import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class GrowScreenVm {
  final BuildContext _context;
  final PartnersProvider _partnersProvider;

  GrowScreenVm(
    this._context,
    this._partnersProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final partners = ValueNotifier<List<PartnerApiModel>?>(null);

  void _init() {
    _partnersProvider.addListener(_partnersProviderListener);
    _refreshPartners();
  }

  void dispose() {
    _partnersProvider.removeListener(_partnersProviderListener);

    loading.dispose();
    partners.dispose();
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
    if (!_context.mounted) return;
    _context.goNamed(
      AppRoute.startChat.name,
      extra: partner,
    );
  }

  void _partnersProviderListener() {
    if (!_context.mounted) return;
    partners.value = _partnersProvider.partners;
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
