/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/sales_transactions/presentation/widgets/sales_transaction_form.dart';

class SalesTransactionFormPage extends HookConsumerWidget {
  const SalesTransactionFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('SalesTransaction Form Page')),
      body: SalesTransactionForm(id: id),
    );
  }
}
