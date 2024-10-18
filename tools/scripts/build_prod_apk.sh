flutter build apk --dart-define-from-file=tools/configs/prod_config.json

BUILD_VER=$(grep ^"version: " pubspec.yaml | cut -b 10-)
mkdir -p build_artifacts
cp build/app/outputs/flutter-apk/app-release.apk build_artifacts/partnext-$BUILD_VER-prod.apk
