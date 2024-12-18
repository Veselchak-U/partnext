import 'package:flutter/material.dart';

abstract interface class NavBarIndexProvider with ChangeNotifier {
  int navBarIndex = 0;

  void reset();
}

class NavBarIndexProviderImpl with ChangeNotifier implements NavBarIndexProvider {
  static const _initialIndex = 0; // "/home"

  int _navBarIndex = _initialIndex;

  @override
  int get navBarIndex => _navBarIndex;

  @override
  set navBarIndex(int value) {
    _navBarIndex = value;
    notifyListeners();
  }

  @override
  void reset() {
    _navBarIndex = _initialIndex;
    notifyListeners();
  }
}
