// package imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/models/fields/auth_fields.dart';
import 'package:mason_sampler/src/core/routing/router.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_builder.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_field_text.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_field_select.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/features/auths/data/auth_repository.dart';
import 'package:mason_sampler/src/features/auths/presentation/controllers/auth_controller.dart';
import 'package:mason_sampler/src/features/auths/domain/auth_data.dart';

class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({super.key, this.email});

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

      final repository = ref.read(authRepositoryProvider);

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
      child: BasicFormBuilder(
        formKey: formKey,
        isLoading: isLoading.value,
        fields: [
          BasicFormFieldSelect<String>(
            initialValue: 'users',
            name: AuthFields.type,
            options: [
              SelectOption(value: 'users', label: 'Users'),
              SelectOption(value: 'admins', label: 'Admins'),
            ],
            decoration: const InputDecoration(
              label: Text('Type'),
              border: OutlineInputBorder(),
            ),
          ),
          BasicFormFieldText(
            name: AuthFields.identity,
            initialValue: email,
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
          ),
          BasicFormFieldText(
            name: AuthFields.password,
            initialValue: email,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              label: const Text('Password'),
              border: const OutlineInputBorder(),
              suffix: IconButton(
                icon: obscureText.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                onPressed: () => obscureText.value = !obscureText.value,
              )
            ),
          ),
        ],
        onSubmit: (result) => onSave(result),
      ),
    ),
    );
  }
}
