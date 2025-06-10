// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/core/models/dynamic_form_result.dart';
import 'package:mason_sampler/src/features/customers/domain/customer_fields.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/features/customers/data/customer_repository.dart';
import 'package:mason_sampler/src/features/customers/domain/customer.dart';
import 'package:mason_sampler/src/features/customers/presentation/controllers/customer_form_controller.dart';
import 'package:mason_sampler/src/features/customers/presentation/controllers/customer_table_controller.dart';

class CustomerForm extends HookConsumerWidget {
  const CustomerForm({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(customerFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(Customer? customer, DynamicFormResult formResult) async {
      isLoading.value = true;

      final repository = ref.read(customerRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (customer == null
          ? repository.create(value, files: files)
          : repository.update(customer, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
        ref.invalidate(customerTableControllerProvider);
        context.pop(r);
      });
    }

    return provider.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Form Error')),
      data: (formState) {
        final customer = formState.customer;

        return Padding(
          padding: EdgeInsets.only(top: 14, left: 20, right: 20),
          child: DynamicFormBuilder(
            formKey: formKey,
            isLoading: isLoading.value,
            fields: [
              DynamicTextField(
                name: CustomerFields.id,
                initialValue: customer?.id,
                decoration: const InputDecoration(
                  label: Text('Id'),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            onSubmit: (result) => onSave(customer, result),
          ),
        );
      },
    );
  }
}
