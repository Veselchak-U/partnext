import 'package:flutter/material.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';

abstract interface class PartnersProvider with ChangeNotifier {
  List<PartnerApiModel> get partners;

  Future<void> refreshPartners();

  Future<void> approve(PartnerApiModel partner);

  Future<void> reject(PartnerApiModel partner);
}

class PartnersProviderImpl with ChangeNotifier implements PartnersProvider {
  final PartnerRepository _partnerRepository;

  PartnersProviderImpl(this._partnerRepository);

  List<PartnerApiModel> _partners = [];

  @override
  List<PartnerApiModel> get partners => [..._partners];

  @override
  Future<void> refreshPartners() async {
    _partners = await _partnerRepository.getPartners();
    notifyListeners();
  }

  @override
  Future<void> approve(PartnerApiModel partner) async {
    await _partnerRepository.handlePartner(partner.userId, confirm: true);
    _partners.remove(partner);
    notifyListeners();
  }

  @override
  Future<void> reject(PartnerApiModel partner) async {
    await _partnerRepository.handlePartner(partner.userId, confirm: false);
    _partners.remove(partner);
    notifyListeners();
  }
}
