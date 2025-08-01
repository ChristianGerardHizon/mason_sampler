// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/widgets/{{singular.snakeCase()}}_table.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/refresh_button.dart';

class {{plural.pascalCase()}}Page extends HookConsumerWidget {
  const {{plural.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
        appBar: AppBar(
        title: const Text('{{singular.pascalCase()}}'),
        actions: [
          RefreshButton(
            onPressed: () => ref.invalidate({{singular.camelCase()}}TableControllerProvider),
          )
        ],
      ),      
      body: {{singular.pascalCase()}}Table(),
    );
  }
}
