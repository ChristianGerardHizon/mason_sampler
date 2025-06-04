
/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
/// system imports
import 'package:mason_sampler/src/core/routing/router.dart'
    show BranchFormPageRoute, $BranchFormPageRouteExtension;
import 'package:mason_sampler/src/core/controllers/table_controller.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';
import 'package:mason_sampler/src/features/branches/data/branch_repository.dart';
import 'package:mason_sampler/src/features/branches/domain/branch.dart';
import 'package:mason_sampler/src/features/branches/domain/branch_keys.dart';
import 'package:mason_sampler/src/features/branches/presentation/controllers/branch_table_controller.dart';

class BranchesPage extends HookConsumerWidget {
  const BranchesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = BranchKeys.tableKey;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = branchTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(Branch branch) {
      BranchFormPageRoute(id: branch.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(branchTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Branch> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(branchRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        notifier.clearSelection();
        ref.invalidate(branchTableControllerProvider);
        AppSnackBar.root(message: 'Successfully Deleted');
      });
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      BranchFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
        actions: [RefreshButton(onPressed: onRefresh)],
      ),
      body: Center(child: Text('List of Branches')),
    );
  }
}
