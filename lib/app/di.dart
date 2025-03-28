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
import 'package:partnext/app/service/storage/file_cache_service.dart';
import 'package:partnext/app/service/storage/secure_storage_service.dart';
import 'package:partnext/app/service/storage/storage_service.dart';
import 'package:partnext/features/auth/data/datasource/auth_datasource.dart';
import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/auth/domain/use_case/login_use_case.dart';
import 'package:partnext/features/chat/data/datasource/chat_datasource.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/chat/domain/use_case/start_conversation_use_case.dart';
import 'package:partnext/features/file/data/datasource/file_datasource.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/initial/data/datasource/user_local_datasource.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/initial/domain/logic/initial_controller.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/partner/data/datasource/partner_datasource.dart';
import 'package:partnext/features/partner/data/repository/partner_repository.dart';
import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/domain/use_case/logout_use_case.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';
import 'package:partnext/features/profile/domain/use_case/update_user_avatar_use_case.dart';
import 'package:partnext/features/questionnaire/data/datasource/questionnaire_local_datasource.dart';
import 'package:partnext/features/questionnaire/data/datasource/questionnaire_remote_datasource.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';
import 'package:partnext/features/questionnaire/domain/use_case/update_questionnaire_use_case.dart';

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
    _sl.registerSingleton<FileCacheService>(FileCacheServiceImpl());
  }

  void _dataSources() {
    _sl.registerLazySingleton<UserLocalDatasource>(() => UserLocalDatasourceImpl(
          _sl<SecureStorageService>(),
        ));
    _sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<QuestionnaireRemoteDatasource>(() => QuestionnaireRemoteDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<QuestionnaireLocalDatasource>(() => QuestionnaireLocalDatasourceImpl(
          _sl<StorageService>(),
        ));
    _sl.registerLazySingleton<PartnerDatasource>(() => PartnerDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<ProfileDatasource>(() => ProfileDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<ChatDatasource>(() => ChatDatasourceImpl(
          _sl<ApiClient>(),
        ));
    _sl.registerLazySingleton<FileDatasource>(() => FileDatasourceImpl(
          _sl<DioApiClient>(),
          _sl<FileCacheService>(),
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
          _sl<QuestionnaireRemoteDatasource>(),
          _sl<QuestionnaireLocalDatasource>(),
        ));
    _sl.registerLazySingleton<PartnerRepository>(() => PartnerRepositoryImpl(
          _sl<PartnerDatasource>(),
        ));
    _sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
          _sl<ProfileDatasource>(),
          _sl<FileDatasource>(),
        ));
    _sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
          _sl<ChatDatasource>(),
        ));
    _sl.registerLazySingleton<FileRepository>(() => FileRepositoryImpl(
          _sl<FileDatasource>(),
        ));
  }

  void _businessLogic() {
    _sl.registerFactory(() => LoginUseCase(
          _sl<AuthRepository>(),
          _sl<UserRepository>(),
        ));
    _sl.registerFactory(() => LogoutUseCase(
          _sl<UserRepository>(),
          _sl<QuestionnaireRepository>(),
        ));
    _sl.registerFactory(() => UpdateQuestionnaireUseCase(
          _sl<QuestionnaireRepository>(),
          _sl<ProfileRepository>(),
          _sl<UserRepository>(),
        ));
    _sl.registerFactory(() => RefreshUserProfileUseCase(
          _sl<ProfileRepository>(),
          _sl<UserRepository>(),
        ));
    _sl.registerFactory(() => UpdateUserAvatarUseCase(
          _sl<ProfileRepository>(),
          _sl<RefreshUserProfileUseCase>(),
        ));
    _sl.registerFactory(() => StartConversationUseCase(
          _sl<FileRepository>(),
          _sl<ChatRepository>(),
        ));

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
    _sl.registerLazySingleton<ChatListProvider>(() => ChatListProviderImpl(
          _sl<ChatRepository>(),
          _sl<StartConversationUseCase>(),
        ));
    _sl.registerLazySingleton<MessageListProvider>(() => MessageListProviderImpl(
          _sl<ChatRepository>(),
        ));
  }
}
