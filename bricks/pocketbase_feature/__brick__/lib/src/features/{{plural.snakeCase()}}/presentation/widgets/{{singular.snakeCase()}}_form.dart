// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:http/http.dart' as http;
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_fields.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/basic_form_fields/basic_form_builder.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/basic_form_fields/basic_form_field_text.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_form_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';

class {{singular.pascalCase()}}Form extends HookConsumerWidget {
  const {{singular.pascalCase()}}Form({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch({{singular.camelCase()}}FormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave({{singular.pascalCase()}}? {{singular.camelCase()}}, Map<String,dynamic>? values) async {

      if (values == null) {
        AppSnackBar.rootFailure(PresentationFailure('Invalid form'));
        return;
      }

      isLoading.value = true;

      final repository = ref.read({{singular.camelCase()}}RepositoryProvider);
      final value = values;
      final files = <http.MultipartFile>[];

      final task = ({{singular.camelCase()}} == null
          ? repository.create(value, files: files)
          : repository.update({{singular.camelCase()}}, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
        ref.invalidate({{singular.camelCase()}}TableControllerProvider);
        ref.invalidate({{singular.camelCase()}}ControllerProvider(r.id));
        context.pop(r);
      });
    }

    return provider.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Form Error')),
      data: (formState) {
        final {{singular.camelCase()}} = formState.{{singular.camelCase()}};

        return BasicFormBuilder(
          formKey: formKey,
          enabled: !isLoading.value,
          fields: [
            BasicFormFieldText(
              name: {{singular.pascalCase()}}Fields.id,
              initialValue: {{singular.camelCase()}}?.id,
              decoration: const InputDecoration(
                label: Text('Id'),
                border: OutlineInputBorder(),
              ),
            ),
          ],
          onSubmit: (result) => onSave({{singular.camelCase()}}, result),
        );
      },
    );
  }
}
