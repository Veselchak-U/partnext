class GetLocationFromPushUseCase {
  final String? Function() _getLocationFromPush;

  GetLocationFromPushUseCase(
    this._getLocationFromPush,
  );

  String? call() {
    return _getLocationFromPush();
  }
}
