import 'package:flutter/material.dart';
import 'package:{{packageName.snakeCase()}}/src/core/controllers/scaffold_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MobileDrawer extends HookConsumerWidget {
  final BuildContext rootContext;

  const MobileDrawer({super.key, required this.rootContext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldControllerProvider);
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
            ListTile(
              leading: Icon(MIcons.homeOutline),
              title: const Text('Dashboard'),
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Account'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Privacy'),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // handle logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
