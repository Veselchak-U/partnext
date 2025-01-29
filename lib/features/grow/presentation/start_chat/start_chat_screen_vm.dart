import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';

class StartChatScreenVm {
  final BuildContext _context;
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final PartnerApiModel partner;

  StartChatScreenVm(
    this._context,
    this._chatRepository,
    this._userRepository, {
    required this.partner,
  }) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);
  final tappedBackground = ValueNotifier<bool?>(null);

  String myImageUrl = '';

  void _init() {
    _initMyImage();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();
    tappedBackground.dispose();
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
    String message,
    List<File> attachments,
  ) async {
    _setLoading(true);
    try {
      final chat = await _chatRepository.createChat(partner.id);
      await _chatRepository.sendMessage(
        chat.id,
        message,
        attachments: attachments,
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
    _context.pushNamed(
      AppRoute.chat.name,
      extra: chatId,
    );
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

  void onTapBackground() {
    tappedBackground.value = !(tappedBackground.value ?? false);
  }
}
