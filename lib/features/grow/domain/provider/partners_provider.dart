import 'package:flutter/material.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';

abstract interface class PartnersProvider with ChangeNotifier {
  List<PartnerApiModel> get partners;

  Future<void> refreshPartners();

  Future<void> approve(PartnerApiModel partner);

  Future<void> reject(PartnerApiModel partner);

  void clearCache();
}

class PartnersProviderImpl with ChangeNotifier implements PartnersProvider {
  final PartnerRepository _partnerRepository;

  PartnersProviderImpl(this._partnerRepository);

  List<PartnerApiModel> _partnerCache = [];

  @override
  List<PartnerApiModel> get partners => List.unmodifiable(_partnerCache);

  @override
  Future<void> refreshPartners() async {
    _partnerCache = await _partnerRepository.getPartners();
    notifyListeners();
  }

  @override
  Future<void> approve(PartnerApiModel partner) async {
    await _partnerRepository.handlePartner(partner.userId, confirm: true);
    _partnerCache.remove(partner);
    notifyListeners();
  }

  @override
  Future<void> reject(PartnerApiModel partner) async {
    await _partnerRepository.handlePartner(partner.userId, confirm: false);
    _partnerCache.remove(partner);
    notifyListeners();
  }

  @override
  void clearCache() {
    _partnerCache = [];
  }
}
