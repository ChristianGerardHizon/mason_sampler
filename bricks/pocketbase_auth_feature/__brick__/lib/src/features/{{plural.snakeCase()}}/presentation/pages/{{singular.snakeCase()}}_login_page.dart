// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/dynamic_form_result.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/fields/{{singular.snakeCase()}}_fields.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/auth_data.dart';

class {{singular.pascalCase()}}LoginPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}LoginPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.valueOrNull is AuthData) {
        RootRoute().go(context);
      }
    });


    ///
    /// Submit
    ///
    void onSave(DynamicFormResult formResult) async {
      isLoading.value = true;

      final repository = ref.read(authRepositoryProvider);
      final value = formResult.values;

      final task = repository
          .login(value)
          .flatMap(ref.read(authControllerProvider.notifier).setUser);

      final result = await task.run();

      isLoading.value = false;

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        AppSnackBar.root(message: 'Success');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
      padding: EdgeInsets.only(top: 14, left: 20, right: 20),
      child: DynamicFormBuilder(
        formKey: formKey,
        isLoading: isLoading.value,
        fields: [
          DynamicSelectField(
            initialValue: '{{childPlural.snakeCase()}}',
            name: {{singular.pascalCase()}}Fields.type,
            options: [
              SelectOption(value: '{{childPlural.snakeCase()}}', display: '{{childPlural.pascalCase()}}'),
              SelectOption(value: '{{parentPlural.snakeCase()}}', display: '{{parentPlural.pascalCase()}}'),
            ],
            decoration: const InputDecoration(
              label: Text('Type'),
              border: OutlineInputBorder(),
            ),
          ),
          DynamicTextField(
            name: {{singular.pascalCase()}}Fields.identity,
            initialValue: email,
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
          ),
          DynamicPasswordField(
            name: {{singular.pascalCase()}}Fields.password,
            initialValue: email,
            decoration: const InputDecoration(
              label: Text('Password'),
              border: OutlineInputBorder(),
            ),
          ),
        ],
        onSubmit: (result) => onSave(result),
      ),
    ),
    );
  }
}
