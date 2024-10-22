part of 'initial_controller.dart';

sealed class InitialControllerState {
  const InitialControllerState();
}

final class InitialController$Idle extends InitialControllerState {
  const InitialController$Idle();
}

final class InitialController$Loading extends InitialControllerState {
  const InitialController$Loading();
}

final class InitialController$Unauthorized extends InitialControllerState {
  const InitialController$Unauthorized();
}

final class InitialController$Success extends InitialControllerState {
  const InitialController$Success();
}

final class InitialController$Error extends InitialControllerState {
  final Object error;
  final StackTrace stackTrace;

  const InitialController$Error(this.error, this.stackTrace);
}
