import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:partnext/config.dart' as app_config;

abstract interface class FileCacheService {
  Future<File> getFile(String url);
}

class FileCacheServiceImpl implements FileCacheService {
  final BaseCacheManager _cacheManager;

  FileCacheServiceImpl()
      : _cacheManager = CacheManager(
          Config(
            'cachedFileData',
            stalePeriod: app_config.Config.messageFileCacheStalePeriod,
          ),
        );

  @override
  Future<File> getFile(String url) {
    return _cacheManager.getSingleFile(url);
  }
}
