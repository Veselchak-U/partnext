import 'package:flutter/material.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';

abstract interface class NavBarIndexProvider with ChangeNotifier {
  int navBarIndex = NavBarTab.home.index;

  void reset({bool notify = true});
}

class NavBarIndexProviderImpl with ChangeNotifier implements NavBarIndexProvider {
  static final _initialIndex = NavBarTab.home.index;

  int _navBarIndex = _initialIndex;

  @override
  int get navBarIndex => _navBarIndex;

  @override
  set navBarIndex(int value) {
    _navBarIndex = value;
    notifyListeners();
  }

  @override
  void reset({bool notify = true}) {
    _navBarIndex = _initialIndex;
    if (notify) notifyListeners();
  }
}
