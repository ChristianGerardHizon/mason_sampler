// packcage imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart'
    show {{singular.pascalCase()}}FormPageRoute, ${{singular.pascalCase()}}FormPageRouteExtension;
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/failure_message.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/confirm_modal.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/stack_loader.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';

class {{singular.pascalCase()}}Details extends HookConsumerWidget {
  const {{singular.pascalCase()}}Details(this.id, {super.key});

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
    /// State
    ///
    final state = ref.watch({{singular.camelCase()}}ControllerProvider(id));

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate({{singular.camelCase()}}ControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap({{singular.pascalCase()}} {{singular.camelCase()}}) {
      {{singular.pascalCase()}}FormPageRoute(id: {{singular.camelCase()}}.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete({{singular.pascalCase()}} {{singular.camelCase()}}) async {
      final fullTask =
          await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([{{singular.camelCase()}}.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  {{singular.camelCase()}}Id: {{singular.camelCase()}}.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match((failure) => _handleFailure(context, failure), (_) {});
    }

    return state.when(
      error: (error, stack) => FailureMessage(error, stack),
      loading: () => Center(child: CircularProgressIndicator()),
      data: ({{singular.pascalCase()}} {{singular.camelCase()}}) {
        return StackLoader(
          isLoading: isLoading.value,
          child: CustomScrollView(
            slivers: [
              ///
              /// Content
              ///
              SliverList.list(
                children: [
                  SizedBox(height: 20),

                  ///
                  /// Information
                  ///
                  DynamicGroup(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 12,
                    ),
                    header: '{{singular.pascalCase()}} Information',
                    items: [
                      DynamicGroupItem.text(title: 'Id', value: {{singular.camelCase()}}.id),
                    ],
                  ),

                  ///
                  /// Actions
                  ///
                  DynamicGroup(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 12,
                    ),
                    header: 'Actions',
                    items: [
                      DynamicGroupItem.action(
                        onTap: () => tap({{singular.camelCase()}}),
                        leading: Icon(MIcons.fileEditOutline),
                        title: 'Edit Details',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                      DynamicGroupItem.action(
                        titleColor: Theme.of(context).colorScheme.error,
                        onTap: () => onDelete({{singular.camelCase()}}),
                        leading: Icon(
                          MIcons.trashCan,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: 'Delete',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                    ],
                  ),

                  ///
                  /// Spacer
                  ///
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String {{singular.camelCase()}}Id,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh({{singular.camelCase()}}Id);
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
