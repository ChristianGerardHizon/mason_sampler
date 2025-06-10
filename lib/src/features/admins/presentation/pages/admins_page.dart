// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/features/admins/presentation/widgets/admin_table.dart';

class AdminsPage extends HookConsumerWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(title: Text('Admins Page')),
      body: AdminTable(),
    );
  }
}
