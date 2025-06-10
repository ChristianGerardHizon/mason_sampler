/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/admins/presentation/widgets/admin_form.dart';

class AdminFormPage extends HookConsumerWidget {
  const AdminFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Form Page')),
      body: AdminForm(id: id),
    );
  }
}
