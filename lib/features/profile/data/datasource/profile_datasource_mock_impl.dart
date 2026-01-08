import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

class ProfileDatasourceMockImpl implements ProfileDatasource {
  ProfileDatasourceMockImpl();

  @override
  Future<UserApiModel> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockedUser;
  }

  @override
  Future<void> updateUserAvatar(String imageUrl) {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendFeedback(String message) {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<PricingPlanApiModel>> getPricingPlans() async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockedPaymentPlans;
  }

  @override
  Future<String> updatePricingPlan(int planId) async {
    await Future.delayed(const Duration(seconds: 1));

    return 'https://www.google.com';
  }

  @override
  Future<void> cancelPricingPlan() {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> deleteUserProfile() {
    return Future.delayed(const Duration(seconds: 1));
  }
}

final _mockedUser = UserApiModel(
  userId: -1,
  fullName: 'Eli Lavi',
  position: 'Co- Funder and CEO of Unaned',
  imageUrl:
      'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
  pricingPlan: PricingPlanApiModel(
    id: 2,
    name: '3 Month',
    price: 69,
    priceTotal: 207,
    discount: 30,
  ),
);

final _mockedPaymentPlans = [
  PricingPlanApiModel(
    id: 0,
    name: '1 Week',
    price: 29,
    priceTotal: 29,
  ),
  PricingPlanApiModel(
    id: 1,
    name: '1 Month',
    price: 99,
    priceTotal: 99,
    isDefault: true,
  ),
  PricingPlanApiModel(
    id: 2,
    name: '3 Month',
    price: 69,
    priceTotal: 207,
    discount: 30,
  ),
  PricingPlanApiModel(
    id: 3,
    name: '6 Month',
    price: 49,
    priceTotal: 294,
    discount: 50,
  ),
];
