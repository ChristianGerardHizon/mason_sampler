/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:{{packageName.snakeCase()}}/src/core/widgets/refresh_button.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';


class {{singular.pascalCase()}}Page extends HookConsumerWidget {
  const {{singular.pascalCase()}}Page(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('{{singular.pascalCase()}} Details'),
        actions: [
          RefreshButton(
            onPressed: () => ref.invalidate({{singular.camelCase()}}ControllerProvider(id)),
          )
        ],
      ),
      body: Center(child: FlutterLogo(size: 100)),
    );
  }
}