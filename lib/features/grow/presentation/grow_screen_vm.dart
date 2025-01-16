import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/utils/url_launcher.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';

class GrowScreenVm {
  final BuildContext _context;
  final PartnerRepository _partnerRepository;

  GrowScreenVm(
    this._context,
    this._partnerRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final partners = ValueNotifier<List<PartnerApiModel>?>(null);

  void _init() {
    _getPartners();
  }

  void dispose() {
    loading.dispose();
    partners.dispose();
  }

  Future<void> _getPartners() async {
    _setLoading(true);
    try {
      final result = await _partnerRepository.getPartners();

      if (!_context.mounted) return;
      partners.value = result;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void onRefresh() {
    _getPartners();
  }

  void openLink(String? profileUrl) {
    if (profileUrl == null) return;

    UrlLauncher.launchURL(profileUrl);
  }

  void onApprove(PartnerApiModel item) {}

  void onReject(PartnerApiModel item) {}

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message);
  }
}
