import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

class {{singular.pascalCase()}}SplashPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Splash UI
    return ThemeConsumer(
      child: MaterialApp(
        builder: (context, child) {
          return Material(
            child: const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
