// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/core/models/dynamic_form_result.dart';
import 'package:mason_sampler/src/core/models/fields/auth_fields.dart';
import 'package:mason_sampler/src/core/routing/router.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/features/auths/data/auth_repository.dart';
import 'package:mason_sampler/src/features/auths/presentation/controllers/auth_controller.dart';
import 'package:mason_sampler/src/features/auths/presentation/controllers/auth_controller.dart';
import 'package:mason_sampler/src/features/auths/domain/auth_data.dart';

class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({super.key, this.email});

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

      final task = repository.login(value);

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
            initialValue: 'users',
            name: AuthFields.type,
            options: [
              SelectOption(value: 'users', display: 'Users'),
              SelectOption(value: 'admins', display: 'Admins'),
            ],
            decoration: const InputDecoration(
              label: Text('Type'),
              border: OutlineInputBorder(),
            ),
          ),
          DynamicTextField(
            name: AuthFields.identity,
            initialValue: email,
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
          ),
          DynamicPasswordField(
            name: AuthFields.password,
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
