// packcage imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/core/routing/router.dart'
    show SalesTransactionFormPageRoute, $SalesTransactionFormPageRouteExtension;
import 'package:mason_sampler/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:mason_sampler/src/core/widgets/failure_message.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/stack_loader.dart';
import 'package:mason_sampler/src/features/sales_transactions/data/sales_transaction_repository.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';
import 'package:mason_sampler/src/features/sales_transactions/presentation/controllers/sales_transaction_controller.dart';

class SalesTransactionDetails extends HookConsumerWidget {
  const SalesTransactionDetails(this.id, {super.key});

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
    final repo = ref.read(salesTransactionRepositoryProvider);

    ///
    /// State
    ///
    final state = ref.watch(salesTransactionControllerProvider(id));

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(salesTransactionControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(SalesTransaction salesTransaction) {
      SalesTransactionFormPageRoute(id: salesTransaction.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(SalesTransaction salesTransaction) async {
      final fullTask =
          await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([salesTransaction.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  salesTransactionId: salesTransaction.id,
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
      data: (SalesTransaction salesTransaction) {
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
                    header: 'SalesTransaction Information',
                    items: [
                      DynamicGroupItem.text(title: 'Id', value: salesTransaction.id),
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
                        onTap: () => tap(salesTransaction),
                        leading: Icon(MIcons.fileEditOutline),
                        title: 'Edit Details',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                      DynamicGroupItem.action(
                        titleColor: Theme.of(context).colorScheme.error,
                        onTap: () => onDelete(salesTransaction),
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
  required String salesTransactionId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(salesTransactionId);
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
