// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/widgets/{{singular.snakeCase()}}_table.dart';

class {{plural.pascalCase()}}Page extends HookConsumerWidget {
  const {{plural.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(title: Text('{{plural.pascalCase()}} Page')),
      body: {{singular.pascalCase()}}Table(),
    );
  }
}
