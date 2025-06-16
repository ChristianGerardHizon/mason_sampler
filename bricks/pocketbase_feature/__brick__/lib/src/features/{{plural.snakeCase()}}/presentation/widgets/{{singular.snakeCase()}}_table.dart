/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:{{packageName.snakeCase()}}/src/core/controllers/table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/dynamic_table_column.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/failure_message.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/confirm_modal.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/widgets/{{singular.snakeCase()}}_card.dart';

class {{singular.pascalCase()}}Table extends HookConsumerWidget {
  const {{singular.pascalCase()}}Table({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = '{{singular.camelCase()}}';
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = {{singular.camelCase()}}TableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap({{singular.pascalCase()}} {{singular.camelCase()}}) {
      {{singular.pascalCase()}}PageRoute({{singular.camelCase()}}.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate({{singular.camelCase()}}TableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<{{singular.pascalCase()}}> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read({{singular.camelCase()}}RepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        notifier.clearSelection();
        ref.invalidate({{singular.camelCase()}}TableControllerProvider);
        AppSnackBar.root(message: 'Successfully Deleted');
      });
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      {{singular.pascalCase()}}FormPageRoute().push(context);
    }

    return SliverDynamicTableView<{{singular.pascalCase()}}>(
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
        mobileBuilder: (context, index, {{singular.snakeCase()}}, selected) {
          return {{singular.pascalCase()}}Card(
            {{singular.snakeCase()}}: {{singular.snakeCase()}},
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap({{singular.snakeCase()}});
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
