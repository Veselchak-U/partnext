import 'dart:io';

import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';

abstract interface class ProfileRepository {
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _profileDatasource;

  ProfileRepositoryImpl(
    this._profileDatasource,
  );

  @override
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  }) {
    return _profileDatasource.uploadUserAvatar(
      file: file,
      onSendProgress: onSendProgress,
    );
  }
}
