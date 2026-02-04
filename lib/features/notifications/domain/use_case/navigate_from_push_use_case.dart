class NavigateFromPushUseCase {
  final void Function(String) _navigateFromPush;

  NavigateFromPushUseCase(
    this._navigateFromPush,
  );

  void call(String location) {
    _navigateFromPush(location);
  }
}
