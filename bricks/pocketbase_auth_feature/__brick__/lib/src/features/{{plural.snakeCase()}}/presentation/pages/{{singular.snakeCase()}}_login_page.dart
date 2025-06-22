// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/fields/auth_fields.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/basic_form_fields/basic_form_builder.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/basic_form_fields/basic_form_field_text.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/basic_form_fields/basic_form_field_select.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_data.dart';

class {{singular.pascalCase()}}LoginPage extends HookConsumerWidget {
  const {{singular.pascalCase()}}LoginPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final obscureText = useState(true);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.valueOrNull is AuthData) {
        RootRoute().go(context);
      }
    });


    ///
    /// Submit
    ///
    void onSave(Map<String, dynamic>? value) async {

      if (value == null) {
        AppSnackBar.rootFailure(PresentationFailure('Invalid form'));
        return;
      }
      
      isLoading.value = true;

      final repository = ref.read({{singular.camelCase()}}RepositoryProvider);

      final task = repository
          .login(value)
          .flatMap(ref.read({{singular.camelCase()}}ControllerProvider.notifier).setUser);

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
      body: BasicFormBuilder(
        formKey: formKey,
        isLoading: isLoading.value,
        fields: [
          BasicFormFieldSelect<String>(
            initialValue: '{{childPlural.snakeCase()}}',
            name: {{singular.pascalCase()}}Fields.type,
            options: [
              SelectOption(value: '{{childPlural.snakeCase()}}', label: '{{childPlural.pascalCase()}}'),
              SelectOption(value: '{{parentPlural.snakeCase()}}', label: '{{parentPlural.pascalCase()}}'),
            ],
            decoration: const InputDecoration(
              label: Text('Type'),
              border: OutlineInputBorder(),
            ),
          ),
          BasicFormFieldText(
            name: {{singular.pascalCase()}}Fields.identity,
            initialValue: email,
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
          ),
          BasicFormFieldText(
            name: {{singular.pascalCase()}}Fields.password,
            initialValue: email,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              label: const Text('Password'),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: obscureText.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                onPressed: () => obscureText.value = !obscureText.value,
              )
            ),
          ),
        ],
        onSubmit: (result) => onSave(result),
      ),
    );
  }
}
