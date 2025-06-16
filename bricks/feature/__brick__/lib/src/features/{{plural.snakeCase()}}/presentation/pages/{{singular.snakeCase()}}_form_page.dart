/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports

class {{singular.pascalCase()}}FormPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}FormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('{{singular.pascalCase()}} Form Page')),
      body: Center(child: FlutterLogo(size: 100)),
    );
  }
}
