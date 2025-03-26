import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class StartChatScreenVm {
  final BuildContext _context;
  final ChatListProvider _chatListProvider;
  final UserRepository _userRepository;
  final NavBarIndexProvider _navBarIndexProvider;
  final PartnerApiModel partner;

  StartChatScreenVm(
    this._context,
    this._chatListProvider,
    this._userRepository,
    this._navBarIndexProvider, {
    required this.partner,
  }) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);

  String myImageUrl = '';

  void _init() {
    _initMyImage();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();
  }

  Future<void> _initMyImage() async {
    _setInitializing(true);
    try {
      final user = await _userRepository.getUser();
      myImageUrl = user?.imageUrl ?? '';
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setInitializing(false);
  }

  Future<void> onStartConversation(
    String text,
    List<File> attachments,
    RemoteFileType attachmentsType,
  ) async {
    _setLoading(true);
    try {
      final chat = await _chatListProvider.startConversation(
        partner.userId,
        text,
        attachments,
        attachmentsType,
      );
      _goChatScreen(chat.id);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goChatScreen(int chatId) {
    if (!_context.mounted) return;

    final goRouter = GoRouter.of(_context);
    goRouter.pop();

    _navBarIndexProvider.navBarIndex = NavBarTab.chats.index;

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      goRouter.goNamed(
        AppRoute.messages.name,
        extra: chatId,
      );
    });
  }

  void _setInitializing(bool value) {
    if (!_context.mounted) return;
    initializing.value = value;
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message);
  }
}
