# Partnext

Partnext mobile application.

## Generate localization files:

`flutter gen-l10n`

## Code generation

`dart run build_runner build --delete-conflicting-outputs`

## Start project

- PROD-version:
`flutter run lib/main.dart --dart-define-from-file=tools/configs/prod_config.json`
- 
- DEV-version:
`flutter run lib/main.dart --dart-define-from-file=tools/configs/dev_config.json`

## Build prod-versions

APK: `sh tools/scripts/build_prod_apk.sh`
AAB: `sh tools/scripts/build_prod_aab.sh`
IPA: `sh tools/scripts/build_prod_ipa.sh`
