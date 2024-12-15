import 'package:partnext/features/partner/data/datasource/partner_datasource.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

abstract interface class PartnerRepository {
  Future<List<PartnerApiModel>> getRecommendations();
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
}
