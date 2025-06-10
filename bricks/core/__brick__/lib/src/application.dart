import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:{{packageName.snakeCase()}}/src/core/assets/i18n/strings.g.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:theme_provider/theme_provider.dart';

class Application extends HookConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeConsumer(
      child: ResponsiveApp(
        builder: (context) {
          return MaterialApp.router(
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
            debugShowCheckedModeBanner: false,
            title: context.t.common.appName,
            theme: ThemeProvider.themeOf(context).data,
            routerConfig: ref.watch(routerProvider),
            builder: (context, child) {
              return child ?? SizedBox();
            },
          );
        },
      ),
    );
  }
}
