import 'package:flutter/material.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';

class NavBarScreenVm {
  final NavBarIndexProvider _navBarIndexProvider;

  NavBarScreenVm(
    this._navBarIndexProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final pageIndex = ValueNotifier<int>(0);

  void _init() {
    _navBarIndexProvider.addListener(_onPageSelectedOutside);

    pageIndex.value = _navBarIndexProvider.navBarIndex;
  }

  void dispose() {
    _navBarIndexProvider.removeListener(_onPageSelectedOutside);

    loading.dispose();
    pageIndex.dispose();
  }

  // Changes of navBarIndex from inside
  void onPageSelectedInside(int value) {
    pageIndex.value = value;

    if (_navBarIndexProvider.navBarIndex != value) {
      _navBarIndexProvider.navBarIndex = value;
    }
  }

  // Changes of navBarIndex from outside
  void _onPageSelectedOutside() {
    final newIndex = _navBarIndexProvider.navBarIndex;
    if (pageIndex.value == newIndex) return;

    pageIndex.value = newIndex;
  }

  void _setLoading(bool value) {
    loading.value = value;
  }

  void _onError(String message) {
    AppOverlays.showErrorBanner(message);
  }
}
