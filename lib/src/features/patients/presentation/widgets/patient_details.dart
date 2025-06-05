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
    show PatientFormPageRoute, $PatientFormPageRouteExtension;
import 'package:mason_sampler/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:mason_sampler/src/core/widgets/failure_message.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/stack_loader.dart';
import 'package:mason_sampler/src/features/patients/data/patient_repository.dart';
import 'package:mason_sampler/src/features/patients/domain/patient.dart';
import 'package:mason_sampler/src/features/patients/presentation/controllers/patient_controller.dart';

class PatientDetails extends HookConsumerWidget {
  const PatientDetails(this.id, {super.key});

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
    final repo = ref.read(patientRepositoryProvider);

    ///
    /// State
    ///
    final state = ref.watch(patientControllerProvider(id));

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(patientControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(Patient patient) {
      PatientFormPageRoute(id: patient.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(Patient patient) async {
      final fullTask =
          await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([patient.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientId: patient.id,
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
      data: (Patient patient) {
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
                    header: 'Patient Information',
                    items: [
                      DynamicGroupItem.text(title: 'Id', value: patient.id),
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
                        onTap: () => tap(patient),
                        leading: Icon(MIcons.fileEditOutline),
                        title: 'Edit Details',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                      DynamicGroupItem.action(
                        titleColor: Theme.of(context).colorScheme.error,
                        onTap: () => onDelete(patient),
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
  required String patientId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(patientId);
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
