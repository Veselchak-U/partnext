import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

abstract interface class PartnerDatasource {
  Future<List<PartnerApiModel>> getRecommendations();

  Future<void> handleRecommendation(
    int id, {
    required bool confirm,
  });

  Future<List<PartnerApiModel>> getPartners();

  Future<void> handlePartner(int id, {required bool confirm});
}

class PartnerDatasourceImpl implements PartnerDatasource {
  final ApiClient _apiClient;

  PartnerDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<List<PartnerApiModel>> getRecommendations() {
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => [..._mockedPartners],
    // );

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.recommendations}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => PartnerApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> handleRecommendation(
    int id, {
    required bool confirm,
  }) {
    // return Future.delayed(Duration(seconds: 1));

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.handleRecommendation}');

    return _apiClient.post(
      uri,
      body: {
        "id": id,
        "confirm": confirm,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<List<PartnerApiModel>> getPartners() {
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => [..._mockedPartners],
    // );

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.partners}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => PartnerApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> handlePartner(int id, {required bool confirm}) {
    // return Future.delayed(Duration(seconds: 1));

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.handlePartner}');

    return _apiClient.post(
      uri,
      body: {
        "id": id,
        "confirm": confirm,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }
}

// final _mockedPartners = [
//   PartnerApiModel(
//     id: 1,
//     fullName: 'Eli Lavi',
//     questionnaire: QuestionnaireApiModel(
//       myPartnershipTypes: [PartnershipType.activePartner, PartnershipType.strategicPartner],
//       partnerPartnershipTypes: [PartnershipType.ideaHolder],
//       myInterests: [InterestType.insurance, InterestType.realEstate],
//       partnerInterests: [InterestType.fashion, InterestType.creatives],
//       position: 'Co- Funder and CEO of Unnamed',
//       bio:
//           'Hey Im Eli, i have profound background in Cybersecurity and Information Technology is combined with multidisciplinary technological strengths. My hands-on approach, unique expertise and passion for innovation and disruption lend themselves to real value to his customers, partners and investors a like.',
//       experience: ExperienceDuration.from0To2,
//       profileUrl: 'https://www.linkedin.com/company/microsoft/life/f6a483d6-40b8-4204-a9b5-8d47e24da8c0/',
//       photos: [
//         'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
//         'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
//         'https://img.freepik.com/free-photo/copy-space-smiley-friends-mock-up_23-2148342071.jpg?t=st=1734279365~exp=1734282965~hmac=50153a3c41ef38c88bed4e355094b9090d3f81f73cf58b3a9fff645381928551&w=826',
//         'https://img.freepik.com/free-photo/community-young-people-posing-together_23-2148431391.jpg?t=st=1734279366~exp=1734282966~hmac=c846cbf70b9319ec12118bce4db8437f7ce2abdf01a0411321f45b8f55a3e26b&w=1380',
//       ],
//     ),
//   ),
//   PartnerApiModel(
//     id: 2,
//     fullName: 'John Kirby',
//     questionnaire: QuestionnaireApiModel(
//       myPartnershipTypes: [PartnershipType.businessOwner, PartnershipType.startupOwner, PartnershipType.other],
//       partnerPartnershipTypes: [PartnershipType.ideaHolder],
//       myInterests: [InterestType.artAndEntertainment, InterestType.creatives, InterestType.fashion],
//       partnerInterests: [InterestType.education, InterestType.insurance, InterestType.foodAndBeverage],
//       position: 'Startup holder',
//       bio:
//           'Hey Im Eli, i have profound background in Cybersecurity and Information Technology is combined with multidisciplinary technological strengths. My hands-on approach, unique expertise and passion for innovation and disruption lend themselves to real value to his customers, partners and investors a like.',
//       experience: ExperienceDuration.from0To2,
//       profileUrl: 'https://www.linkedin.com/company/microsoft/life/f6a483d6-40b8-4204-a9b5-8d47e24da8c0/',
//       photos: [
//         'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
//         'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
//         'https://img.freepik.com/free-photo/copy-space-smiley-friends-mock-up_23-2148342071.jpg?t=st=1734279365~exp=1734282965~hmac=50153a3c41ef38c88bed4e355094b9090d3f81f73cf58b3a9fff645381928551&w=826',
//         'https://img.freepik.com/free-photo/community-young-people-posing-together_23-2148431391.jpg?t=st=1734279366~exp=1734282966~hmac=c846cbf70b9319ec12118bce4db8437f7ce2abdf01a0411321f45b8f55a3e26b&w=1380',
//       ],
//     ),
//   ),
// ];
