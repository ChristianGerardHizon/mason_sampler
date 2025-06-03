import 'package:flutter/material.dart';
import 'package:mason_sampler/src/application.dart';
import 'package:mason_sampler/src/core/assets/i18n/strings.g.dart';
import 'package:mason_sampler/src/core/loggers/riverpod_logger.dart';
import 'package:mason_sampler/src/core/utils/window_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  ///
  /// Ensure the WidgetsBinding is initialized
  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Set window initial settings
  ///
  await WindowUtils.register();

  ///
  /// Set locale for translations
  ///
  LocaleSettings.useDeviceLocale();

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: TranslationProvider(child: Application()),
    ),
  );
}
