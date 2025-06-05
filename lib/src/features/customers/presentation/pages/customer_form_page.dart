/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/customers/presentation/widgets/customer_form.dart';

class CustomerFormPage extends HookConsumerWidget {
  const CustomerFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Form Page')),
      body: CustomerForm(id: id),
    );
  }
}
