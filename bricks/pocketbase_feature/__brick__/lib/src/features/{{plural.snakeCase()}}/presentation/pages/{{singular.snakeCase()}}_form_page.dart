/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/{{plural.snakeCase()}}/presentation/widgets/{{singular.snakeCase()}}_form.dart';

class {{singular.pascalCase()}}FormPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}FormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('{{singular.pascalCase()}} Form Page')),
      body: {{singular.pascalCase()}}Form(id: id),
    );
  }
}
