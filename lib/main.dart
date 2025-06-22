import 'package:flutter/material.dart';
import 'package:mason_sampler/src/application.dart';
import 'package:mason_sampler/src/core/assets/i18n/strings.g.dart';
import 'package:mason_sampler/src/core/loggers/riverpod_logger.dart';
import 'package:mason_sampler/src/core/utils/window_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

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
  final color = Color.fromARGB(0, 40, 122, 111);
  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: TranslationProvider(
        child: ThemeProvider(
          defaultThemeId: 'light',
          saveThemesOnChange: true,
          loadThemeOnInit: true,
          themes: [
            ///
            /// Light Theme
            ///
            AppTheme(
              id: 'light',
              description: 'Light Theme',
              data: ThemeData(
                brightness: Brightness.light,
                colorSchemeSeed: color,
              ),
            ),

            ///
            /// Dark Theme
            ///
            AppTheme(
              id: 'dark',
              description: 'Dark Theme',
              data: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: color,
              ),
            ),
          ],
          child: Application(),
        ),
      ),
    ),
  );
}
