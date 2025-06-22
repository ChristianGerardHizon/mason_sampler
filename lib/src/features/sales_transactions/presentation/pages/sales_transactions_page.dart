// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/features/sales_transactions/presentation/widgets/sales_transaction_table.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_table_controller.dart';
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';

class SalesTransactionsPage extends HookConsumerWidget {
  const SalesTransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
        appBar: AppBar(
        title: const Text('SalesTransaction Details'),
        actions: [
          RefreshButton(
            onPressed: () => ref.invalidate(salesTransactionTableControllerProvider),
          )
        ],
      ),      
      body: SalesTransactionTable(),
    );
  }
}
