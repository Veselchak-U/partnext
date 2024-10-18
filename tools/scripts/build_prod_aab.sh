flutter build appbundle --dart-define-from-file=tools/configs/prod_config.json

BUILD_VER=$(grep ^"version: " pubspec.yaml | cut -b 10-)
mkdir -p build_artifacts
mv build/app/outputs/bundle/release/app-release.aab build_artifacts/partnext-$BUILD_VER-prod.aab
