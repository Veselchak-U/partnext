import 'package:partnext/features/auth/data/datasource/auth_datasource.dart';
import 'package:partnext/features/auth/data/model/login_api_model.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

class AuthDatasourceMockImpl implements AuthDatasource {
  AuthDatasourceMockImpl();

  @override
  Future<void> register(String fullName, String phone) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> requestOtp(String phone) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<LoginApiModel> login(String phone, String code) async {
    await Future.delayed(Duration(seconds: 1));

    return LoginApiModel(
      userId: -1,
      fullName: 'Eli Lavi',
      position: 'Co- Funder and CEO of Unaned',
      token: 'token',
      imageUrl:
          'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
      // pricingPlan: null,
      pricingPlan: PricingPlanApiModel(
        id: 2,
        name: '3 Month',
        price: 69,
        priceTotal: 207,
        discount: 30,
      ),
    );
  }
}
