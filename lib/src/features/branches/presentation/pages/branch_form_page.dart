/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
/// system imports
import 'package:mason_sampler/src/features/branches/presentation/controllers/branch_form_controller.dart';
import 'package:mason_sampler/src/features/branches/domain/branch.dart';
import 'package:mason_sampler/src/features/branches/presentation/controllers/branch_table_controller.dart';
import 'package:mason_sampler/src/core/models/dynamic_form_result.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/features/branches/data/branch_repository.dart';


class BranchFormPage extends HookConsumerWidget {
  const BranchFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(branchFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(Branch? branch, DynamicFormResult formResult) async {
      isLoading.value = true;

      final repository = ref.read(branchRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (branch == null
          ? repository.create(value, files: files)
          : repository.update(branch!, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
        ref.invalidate(branchTableControllerProvider);
        context.pop(r);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Branch Form Page')),
      body: provider.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Form Error')),
        data: (formState) {
          final branch = formState.branch;

          return Center(child: Text('Form'));
        },
      ),
    );
  }
}
