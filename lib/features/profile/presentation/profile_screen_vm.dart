import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/dialogs/app_dialogs.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/domain/use_case/logout_use_case.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';
import 'package:partnext/features/profile/domain/use_case/update_user_avatar_use_case.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_params.dart';

class ProfileScreenVm {
  final BuildContext _context;
  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;
  final RefreshUserProfileUseCase _refreshUserProfileUseCase;
  final UpdateUserAvatarUseCase _updateUserAvatarUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileScreenVm(
    this._context,
    this._userRepository,
    this._profileRepository,
    this._refreshUserProfileUseCase,
    this._updateUserAvatarUseCase,
    this._logoutUseCase,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final user = ValueNotifier<UserApiModel?>(null);

  void _init() {
    _initUser();
  }

  void dispose() {
    loading.dispose();
    user.dispose();
  }

  Future<void> _initUser() async {
    _setLoading(true);
    try {
      final result = await _userRepository.getUser();

      if (!_context.mounted) return;
      if (result == null) {
        logOut();

        return;
      }

      user.value = result;
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> changeUserAvatar() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (image == null) return;

    _setLoading(true);
    try {
      await _updateUserAvatarUseCase(image.path);

      if (!_context.mounted) return;
      _initUser();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> refreshUserProfile() async {
    await _refreshUserProfileUseCase();
    _initUser();
  }

  void goUpgrade() {
    _context.pushNamed(AppRoute.upgrade.name);
  }

  void goSendFeedback() {
    _context.pushNamed(AppRoute.sendFeedback.name);
  }

  void goEditProfile() {
    _context.pushNamed(
      AppRoute.questionnaire.name,
      extra: QuestionnaireScreenParams(isEdit: true),
    );
  }

  Future<void> logOut() async {
    final dialogResult = await AppDialogs.showConfirmationDialog(
      context: _context,
      title: _context.l10n.sing_out,
      description: _context.l10n.sure_to_logout,
    );
    if (dialogResult != true) return;

    _setLoading(true);
    try {
      await _logoutUseCase();

      _goInitialScreen();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  Future<void> deleteAccount() async {
    final dialogResult = await AppDialogs.showConfirmationDialog(
      context: _context,
      title: _context.l10n.delete_account,
      description: _context.l10n.sure_to_delete_account,
      confirmLabel: _context.l10n.delete,
      isDanger: true,
    );
    if (dialogResult != true) return;

    _setLoading(true);
    try {
      await _profileRepository.deleteUserProfile();

      await _logoutUseCase();

      _goInitialScreen();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goInitialScreen() {
    if (!_context.mounted) return;
    _context.goNamed(AppRoute.initial.name);

    //TODO: reset nav bar index after logout
    // _navBarIndexProvider.reset();
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
