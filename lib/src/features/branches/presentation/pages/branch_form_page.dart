/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/branches/presentation/widgets/branch_form.dart';

class BranchFormPage extends HookConsumerWidget {
  const BranchFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Branch Form Page')),
      body: BranchForm(id: id),
    );
  }
}
