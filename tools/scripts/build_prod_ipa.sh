flutter build ipa --dart-define-from-file=tools/configs/prod_config.json

BUILD_VER=`grep ^"version: " pubspec.yaml | cut -b 10-`
mkdir -p build_artifacts
mv build/ios/ipa/Partnext.ipa build_artifacts/partnext-$BUILD_VER-prod.ipa
zip -d build_artifacts/partnext-$BUILD_VER-prod.ipa ._Symbols/
