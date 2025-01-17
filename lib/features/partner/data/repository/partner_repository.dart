import 'package:partnext/features/partner/data/datasource/partner_datasource.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

abstract interface class PartnerRepository {
  Future<List<PartnerApiModel>> getRecommendations();

  Future<void> handleRecommendation(int id, {required bool confirm});

  Future<List<PartnerApiModel>> getPartners();

  Future<void> handlePartner(int id, {required bool confirm});
}

class PartnerRepositoryImpl implements PartnerRepository {
  final PartnerDatasource _partnerDatasource;

  PartnerRepositoryImpl(
    this._partnerDatasource,
  );

  @override
  Future<List<PartnerApiModel>> getRecommendations() {
    return _partnerDatasource.getRecommendations();
  }

  @override
  Future<void> handleRecommendation(int id, {required bool confirm}) {
    return _partnerDatasource.handleRecommendation(id, confirm: confirm);
  }

  @override
  Future<List<PartnerApiModel>> getPartners() {
    return _partnerDatasource.getPartners();
  }

  @override
  Future<void> handlePartner(int id, {required bool confirm}) {
    return _partnerDatasource.handlePartner(id, confirm: confirm);
  }
}
