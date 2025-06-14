/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/refresh_button.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/widgets/{{singular.snakeCase()}}_details.dart';


class {{singular.pascalCase()}}Page extends HookConsumerWidget {
  const {{singular.pascalCase()}}Page(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate({{singular.camelCase()}}ControllerProvider(id));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('{{singular.pascalCase()}} Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: {{singular.pascalCase()}}Details(id),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String {{singular.snakeCase()}}Id,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh({{singular.snakeCase()}}Id);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
