/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart' show {{singular.pascalCase()}}FormPageRoute, ${{singular.pascalCase()}}FormPageRouteExtension;
import 'package:{{packageName.snakeCase()}}/src/core/widgets/failure_message.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/refresh_button.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/confirm_modal.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/stack_loader.dart';


class {{singular.pascalCase()}}Page extends HookConsumerWidget {
  const {{singular.pascalCase()}}Page(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read({{singular.camelCase()}}RepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate({{singular.camelCase()}}ControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap({{singular.pascalCase()}} {{singular.snakeCase()}}) {
      {{singular.pascalCase()}}FormPageRoute(id: {{singular.snakeCase()}}.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete({{singular.pascalCase()}} {{singular.snakeCase()}}) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([{{singular.snakeCase()}}.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  {{singular.snakeCase()}}Id: {{singular.snakeCase()}}.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
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
      body: ref.watch({{singular.camelCase()}}ControllerProvider(id)).when(
            error: (error, stack) => FailureMessage(error, stack),
            loading: () => Center(child: CircularProgressIndicator()),
            data: ({{singular.snakeCase()}}) {
              return StackLoader(
                isLoading: isLoading.value,
                child: CustomScrollView(
                  slivers: [
                    
                    ///
                    /// Add Content Here
                    ///

                  ],
                ),
              );
            },
          ),
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
