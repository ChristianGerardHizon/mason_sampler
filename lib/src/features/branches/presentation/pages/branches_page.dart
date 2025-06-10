// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/features/branches/presentation/widgets/branch_table.dart';

class BranchesPage extends HookConsumerWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(title: Text('Branches Page')),
      body: BranchTable(),
    );
  }
}
