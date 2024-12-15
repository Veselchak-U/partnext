import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';

class HomeScreenVm {
  final BuildContext _context;
  final PartnerRepository _partnerRepository;
  final UserRepository _userRepository;

  HomeScreenVm(
    this._context,
    this._partnerRepository,
    this._userRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final recommendations = ValueNotifier<List<PartnerApiModel>>([]);

  void _init() {
    getRecommendations();
  }

  void dispose() {
    loading.dispose();
    recommendations.dispose();
  }

  Future<void> getRecommendations() async {
    _setLoading(true);
    try {
      final result = await _partnerRepository.getRecommendations();

      if (!_context.mounted) return;
      recommendations.value = result;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> logOut() async {
    _setLoading(true);
    try {
      await _userRepository.setUser(null);

      _goInitialScreen();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goInitialScreen() {
    if (!_context.mounted) return;
    _context.goNamed(AppRoute.initial.name);
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
