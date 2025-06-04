
/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
/// system imports
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart'
    show {{singular.pascalCase()}}FormPageRoute, ${{singular.pascalCase()}}FormPageRouteExtension;
import 'package:{{packageName.snakeCase()}}/src/core/controllers/table_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/app_snackbar.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/confirm_modal.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/refresh_button.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_keys.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_table_controller.dart';

class {{plural.pascalCase()}}Page extends HookConsumerWidget {
  const {{plural.pascalCase()}}Page({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = {{singular.pascalCase()}}Keys.tableKey;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = {{singular.snakeCase()}}TableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap({{singular.pascalCase()}} {{singular.snakeCase()}}) {
      {{singular.pascalCase()}}FormPageRoute(id: {{singular.snakeCase()}}.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate({{singular.snakeCase()}}TableControllerProvider);
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

    return Scaffold(
      appBar: AppBar(
        title: Text('{{plural.pascalCase()}}'),
        actions: [RefreshButton(onPressed: onRefresh)],
      ),
      body: Center(child: Text('List of {{plural.pascalCase()}}')),
    );
  }
}
