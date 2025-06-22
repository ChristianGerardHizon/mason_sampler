/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_controller.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/widgets/sales_transaction_details.dart';


class SalesTransactionPage extends HookConsumerWidget {
  const SalesTransactionPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('SalesTransaction Details'),
        actions: [
          RefreshButton(
            onPressed: () => ref.invalidate(salesTransactionControllerProvider(id)),
          )
        ],
      ),
      body: SalesTransactionDetails(id),
    );
  }
}