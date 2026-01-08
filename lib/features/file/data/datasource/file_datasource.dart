import 'dart:io';

import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';
import 'package:partnext/app/service/storage/file_cache_service.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';

abstract interface class FileDatasource {
  Future<FileApiModel> uploadFile({
    required String path,
    required RemoteFileType type,
    required String name,
    Function(int count, int total)? onSendProgress,
  });

  Future<File> getFile(String url);
}

class FileDatasourceImpl implements FileDatasource {
  final DioApiClient _dioApiClient;
  final FileCacheService _fileCacheService;

  FileDatasourceImpl(
    this._dioApiClient,
    this._fileCacheService,
  );

  @override
  Future<FileApiModel> uploadFile({
    required String path,
    required RemoteFileType type,
    required String name,
    Function(int count, int total)? onSendProgress,
  }) async {
    final data = await _dioApiClient.uploadImage(
      Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.uploadFile}'),
      path,
      formDataMap: {
        "type": type.name,
        "name": name,
      },
      onSendProgress: onSendProgress,
    );

    return FileApiModel.fromJson(data);
  }

  @override
  Future<File> getFile(String url) {
    return _fileCacheService.getFile(url);
  }
}
