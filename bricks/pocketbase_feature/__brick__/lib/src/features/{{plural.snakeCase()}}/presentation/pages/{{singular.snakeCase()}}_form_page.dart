/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
/// system imports
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_form_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/dynamic_form_result.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';


class {{singular.pascalCase()}}FormPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}FormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch({{singular.camelCase()}}FormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave({{singular.pascalCase()}}? {{singular.snakeCase()}}, DynamicFormResult formResult) async {
      isLoading.value = true;

      final repository = ref.read({{singular.camelCase()}}RepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = ({{singular.snakeCase()}} == null
          ? repository.create(value, files: files)
          : repository.update({{singular.snakeCase()}}!, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
        ref.invalidate({{singular.camelCase()}}TableControllerProvider);
        context.pop(r);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('{{singular.pascalCase()}} Form Page')),
      body: provider.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Form Error')),
        data: (formState) {
          final {{singular.snakeCase()}} = formState.{{singular.snakeCase()}};

          return Center(child: Text('Form'));
        },
      ),
    );
  }
}
