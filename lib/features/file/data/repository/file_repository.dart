import 'dart:io';

import 'package:partnext/features/file/data/datasource/file_datasource.dart';

abstract interface class FileRepository {
  Future<String> uploadFile({
    required String filePath,
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
  Future<String> uploadFile({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  }) {
    return _fileDatasource.uploadFile(
      filePath: filePath,
      onSendProgress: onSendProgress,
    );
  }

  @override
  Future<File> getFile(String url) {
    return _fileDatasource.getFile(url);
  }
}
