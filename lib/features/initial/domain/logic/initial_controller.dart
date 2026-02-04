import 'dart:async';

import 'package:control/control.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/notifications/domain/use_case/get_location_from_push_use_case.dart';
import 'package:partnext/features/notifications/domain/use_case/navigate_from_push_use_case.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

part 'initial_controller_state.dart';

final class InitialController extends StateController<InitialControllerState> with SequentialControllerHandler {
  final UserRepository _userRepository;
  final QuestionnaireRepository _questionnaireRepository;
  final GetLocationFromPushUseCase _getLocationFromPushUseCase;
  final NavigateFromPushUseCase _navigateFromPushUseCase;

  InitialController(
    this._userRepository,
    this._questionnaireRepository,
    this._getLocationFromPushUseCase,
    this._navigateFromPushUseCase, {
    super.initialState = const InitialController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> authChecking() {
    return handle(
      () async {
        setState(const InitialController$Loading());

        final location = _getLocationFromPushUseCase();
        if (location != null) {
          setState(const InitialController$HasLocationFromPush());
          _navigateFromPushUseCase(location);

          return;
        }

        final token = await _userRepository.getAccessToken();
        if (token == null) {
          setState(const InitialController$Unauthorized());

          return;
        }

        final questionnaire = await _questionnaireRepository.getQuestionnaire();
        if (questionnaire == null || !questionnaire.isComplete) {
          setState(const InitialController$QuestionnaireRequired());

          return;
        }

        setState(const InitialController$Success());
      },
      error: _errorHandler,
      done: _doneHandler,
    );
  }

  Future<void> _errorHandler(Object e, StackTrace st) async {
    setState(InitialController$Error(e, st));
  }

  Future<void> _doneHandler() async {
    setState(const InitialController$Idle());
  }
}
