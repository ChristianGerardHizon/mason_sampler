/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/core/controllers/table_controller.dart';
import 'package:mason_sampler/src/core/models/dynamic_table_column.dart';
import 'package:mason_sampler/src/core/routing/router.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:mason_sampler/src/core/widgets/failure_message.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';
import 'package:mason_sampler/src/features/admins/data/admin_repository.dart';
import 'package:mason_sampler/src/features/admins/domain/admin.dart';
import 'package:mason_sampler/src/features/admins/presentation/controllers/admin_table_controller.dart';
import 'package:mason_sampler/src/features/admins/presentation/widgets/admin_card.dart';

class AdminTable extends HookConsumerWidget {
  const AdminTable({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = 'admin';
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = adminTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(Admin admin) {
      AdminPageRoute(admin.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(adminTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Admin> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(adminRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        notifier.clearSelection();
        ref.invalidate(adminTableControllerProvider);
        AppSnackBar.root(message: 'Successfully Deleted');
      });
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      AdminFormPageRoute().push(context);
    }

    return SliverDynamicTableView<Admin>(
        tableKey: tableKey,
        error: FailureMessage.asyncValue(listState),
        isLoading: listState.isLoading,
        items: listState.valueOrNull ?? [],
        onDelete: onDelete,
        onRowTap: onTap,

        ///
        /// Search Features
        ///
        searchCtrl: searchCtrl,
        onCreate: onCreate,

        ///
        /// Table Data
        ///
        columns: [
          DynamicTableColumn(
            header: 'Id',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(overflow: TextOverflow.ellipsis, data.id),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, admin, selected) {
          return AdminCard(
            admin: admin,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(admin);
            },
            selected: selected,
            onLongPress: () {
              notifier.toggleRow(index);
            },
          );
        },
      );
  }
}
