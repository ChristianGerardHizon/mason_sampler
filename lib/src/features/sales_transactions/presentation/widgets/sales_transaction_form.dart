// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:http/http.dart' as http;
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction_fields.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_builder.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_field_text.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/features/sales_transactions/data/sales_transaction_repository.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_form_controller.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_table_controller.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_controller.dart';
import 'package:mason_sampler/src/core/models/failure.dart';

class SalesTransactionForm extends HookConsumerWidget {
  const SalesTransactionForm({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(salesTransactionFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(SalesTransaction? salesTransaction, Map<String,dynamic>? values) async {

      if (values == null) {
        AppSnackBar.rootFailure(PresentationFailure('Invalid form'));
        return;
      }

      isLoading.value = true;

      final repository = ref.read(salesTransactionRepositoryProvider);
      final value = values;
      final files = <http.MultipartFile>[];

      final task = (salesTransaction == null
          ? repository.create(value, files: files)
          : repository.update(salesTransaction, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
        ref.invalidate(salesTransactionTableControllerProvider);
        ref.invalidate(salesTransactionControllerProvider(r.id));
        context.pop(r);
      });
    }

    return provider.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Form Error')),
      data: (formState) {
        final salesTransaction = formState.salesTransaction;

        return Padding(
          padding: EdgeInsets.only(top: 14, left: 20, right: 20),
          child: BasicFormBuilder(
            formKey: formKey,
            isLoading: isLoading.value,
            fields: [
              BasicFormFieldText(
                name: SalesTransactionFields.id,
                initialValue: salesTransaction?.id,
                decoration: const InputDecoration(
                  label: Text('Id'),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            onSubmit: (result) => onSave(salesTransaction, result),
          ),
        );
      },
    );
  }
}
