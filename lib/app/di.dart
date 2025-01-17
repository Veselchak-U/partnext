import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:partnext/app/navigation/app_navigation.dart';
import 'package:partnext/app/navigation/app_navigation_observer.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_auth_interceptor.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_error_interceptor.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_log_interceptor.dart';
import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';
import 'package:partnext/app/service/storage/secure_storage_service.dart';
import 'package:partnext/app/service/storage/storage_service.dart';
import 'package:partnext/features/auth/data/datasource/auth_datasource.dart';
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/initial/data/datasource/user_local_datasource.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/partner/data/datasource/partner_datasource.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/questionnaire/data/datasource/questionnaire_datasource.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class DI {
  static final _sl = GetIt.instance;

  static T get<T extends Object>() => _sl<T>();

  void init() {
    _services();
    _dataSources();
    _repositories();
    _businessLogic();
    _providers();
  }

  void _services() {
    _sl.registerSingleton<StorageService>(StorageServiceImpl());
    _sl.registerSingleton<SecureStorageService>(SecureStorageServiceImpl());
    _sl.registerSingleton<AppNavigationObserver>(AppNavigationObserver());

    _sl.registerSingleton<ApiClient>(ApiClient(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
      },
      interceptors: [
        HttpAuthInterceptor(
          getAccessToken: () => _sl<UserLocalDatasource>().getAccessToken(),
          setAccessToken: (value) => _sl<UserLocalDatasource>().setAccessToken(value),
          goLoginScreen: () => AppNavigation.goToScreen(name: AppRoute.login.name),
        ),
        const HttpLogInterceptor(),
        const HttpErrorInterceptor(),
      ],
    ));

    _sl.registerSingleton<DioApiClient>(DioApiClient(
      getAccessToken: () => _sl<UserLocalDatasource>().getAccessToken(),
    ));
  }

  void _dataSources() {
    _sl.registerLazySingleton<UserLocalDatasource>(() => UserLocalDatasourceImpl(
          _sl<StorageService>(),
          _sl<SecureStorageService>(),
        ));
    _sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<QuestionnaireDatasource>(() => QuestionnaireDatasourceImpl(
          _sl<ApiClient>(),
          _sl<DioApiClient>(),
        ));
    _sl.registerLazySingleton<PartnerDatasource>(() => PartnerDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<ProfileDatasource>(() => ProfileDatasourceImpl(
          _sl<ApiClient>(),
          _sl<DioApiClient>(),
        ));
  }

  void _repositories() {
    _sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
          _sl<UserLocalDatasource>(),
        ));
    _sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          _sl<AuthDatasource>(),
        ));
    _sl.registerLazySingleton<QuestionnaireRepository>(() => QuestionnaireRepositoryImpl(
          _sl<QuestionnaireDatasource>(),
          _sl<UserLocalDatasource>(),
        ));
    _sl.registerLazySingleton<PartnerRepository>(() => PartnerRepositoryImpl(
          _sl<PartnerDatasource>(),
        ));
    _sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
          _sl<ProfileDatasource>(),
        ));
  }

  void _businessLogic() {
    _sl.registerFactory(() => InitialController(
          _sl<UserRepository>(),
          _sl<QuestionnaireRepository>(),
        ));
  }

  void _providers() {
    _sl.registerLazySingleton<NavBarIndexProvider>(() => NavBarIndexProviderImpl());
    _sl.registerLazySingleton<PartnersProvider>(() => PartnersProviderImpl(
          _sl<PartnerRepository>(),
        ));
  }
}
