# mason_sampler

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


<!-- run -->

mason make core -c tools/core_config.json ; dart pub get ; dart run build_runner build --delete-conflicting-outputs; dart run slang

mason make pocketbase_feature -c tools/pocketbase_feature_config.json --on-conflict=overwrite; dart pub get ; dart run build_runner build --delete-conflicting-outputs

mason make pocketbase_auth_feature -c tools/pocketbase_auth_feature_config.json --on-conflict=overwrite; dart pub get ; dart run build_runner build --delete-conflicting-outputs