import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/controllers/nav_items_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/controllers/scaffold_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/extensions/string.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MobileDrawer extends HookConsumerWidget {
  final BuildContext rootContext;
  final GoRouterState routerState;

  const MobileDrawer({
    super.key,
    required this.rootContext,
    required this.routerState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldControllerProvider);
    final navItems = ref.watch(navItemsControllerProvider);
    final items = navItems.valueOrNull ?? [];
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Center(child: Logo()),
            ),
            ...items
                .map(
                  (e) => ListTile(
                    leading: e.icon,
                    selected: e.route == routerState.fullPath,
                    title: Text(e.label.optional()),
                    onTap: () {
                      e.onTap?.call(context);
                      scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
