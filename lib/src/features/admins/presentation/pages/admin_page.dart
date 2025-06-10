/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';
import 'package:mason_sampler/src/features/admins/presentation/controllers/admin_controller.dart';
import 'package:mason_sampler/src/features/admins/presentation/widgets/admin_details.dart';


class AdminPage extends HookConsumerWidget {
  const AdminPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(adminControllerProvider(id));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: AdminDetails(id),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String adminId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(adminId);
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
