// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/features/customers/presentation/widgets/customer_table.dart';

class CustomersPage extends HookConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(title: Text('Customers Page')),
      body: CustomerTable(),
    );
  }
}
