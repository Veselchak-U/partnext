import 'package:flutter/material.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';

class NavBarScreenVm {
  final NavBarIndexProvider _navBarIndexProvider;
  final ChatListProvider _chatListProvider;

  NavBarScreenVm(
    this._navBarIndexProvider,
    this._chatListProvider,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final pageIndex = ValueNotifier<int>(NavBarTab.home.index);
  final unreadChatCount = ValueNotifier<int>(0);

  void _init() {
    _navBarIndexProvider.addListener(_onPageSelectedOutside);
    pageIndex.value = _navBarIndexProvider.navBarIndex;

    _chatListProvider.addListener(_chatListListener);
    _chatListProvider.startChecking();
  }

  void dispose() {
    _navBarIndexProvider.removeListener(_onPageSelectedOutside);
    _chatListProvider.removeListener(_chatListListener);

    loading.dispose();
    pageIndex.dispose();
    unreadChatCount.dispose();
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

  void _chatListListener() {
    unreadChatCount.value = _chatListProvider.unreadChatCount;
  }

  void _setLoading(bool value) {
    loading.value = value;
  }

  void _onError(String message) {
    AppOverlays.showErrorBanner(message);
  }
}
