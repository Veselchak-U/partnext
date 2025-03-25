import 'dart:io';

import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/file/data/datasource/file_datasource.dart';
import 'package:path/path.dart' as p;

abstract interface class FileRepository {
  Future<FileApiModel> uploadFile({
    required String path,
    required RemoteFileType type,
    String? name,
    Function(int count, int total)? onSendProgress,
  });

  Future<File> getFile(
    String url,
  );
}

class FileRepositoryImpl implements FileRepository {
  final FileDatasource _fileDatasource;

  FileRepositoryImpl(this._fileDatasource);

  @override
  Future<FileApiModel> uploadFile({
    required String path,
    required RemoteFileType type,
    String? name,
    Function(int count, int total)? onSendProgress,
  }) {
    final fileName = name ?? p.basename(path);

    return _fileDatasource.uploadFile(
      path: path,
      type: type,
      name: fileName,
      onSendProgress: onSendProgress,
    );
  }

  @override
  Future<File> getFile(String url) {
    return _fileDatasource.getFile(url);
  }
}
