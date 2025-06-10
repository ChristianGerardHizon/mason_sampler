import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/core/widgets/logo.dart';
import 'package:mason_sampler/src/core/routing/router.dart';
import 'package:mason_sampler/src/core/controllers/scaffold_controller.dart';
import 'package:mason_sampler/src/core/controllers/nav_items_controller.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/mobile_bottom_nav.dart';
import 'package:mason_sampler/src/core/widgets/mobile_drawer.dart';

class AppRoot extends HookConsumerWidget {
  final StatefulNavigationShell shell;
  final GoRouterState routerState;

  const AppRoot({super.key, required this.shell, required this.routerState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// theme of the app.
    ///
    final theme = Theme.of(context);

    final scaffoldKey = ref.watch(scaffoldControllerProvider);

    final sideMenuCtrl = useMemoized(() => SideMenuController(), []);
    final canPop = useState(false);

    final errorWidget = SizedBox();
    final loadingWidget = SizedBox();

    final state = ref.watch(navItemsControllerProvider);

    return Scaffold(
      key: scaffoldKey,
      drawer: MobileDrawer(rootContext: context),
      body: Builder(
        builder: (context) {
          /// has error
          if (state.hasError) return errorWidget;

          /// is loading
          if (state.isLoading) return loadingWidget;

          /// has value
          final items = state.value ?? [];

          final isDesktop = getValueForScreenType<bool>(
            context: context,
            mobile: false,
            desktop: true,
            tablet: true,
          );

          if (isDesktop) {
            return Row(
              children: [
                SideMenu(
                  minWidth: 80,
                  maxWidth: 200,
                  controller: sideMenuCtrl,
                  mode: SideMenuMode.open,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  builder: (data) => SideMenuData(
                    header: Logo(height: sideMenuCtrl.isCollapsed() ? 60 : 150),
                    items: items.mapWithIndex((e, index) {
                      final goRouter = GoRouter.of(context);
                      final currentLocation = goRouter
                          .routerDelegate
                          .currentConfiguration
                          .uri
                          .toString();
                      return SideMenuItemDataTile(
                        decoration: BoxDecoration(
                          color: currentLocation == e.route
                              ? theme.colorScheme.primaryContainer.withValues(
                                  alpha: .3,
                                )
                              : null,
                        ),
                        clipBehavior: Clip.none,
                        titleStyle: TextStyle(
                          color: currentLocation == e.route
                              ? theme.colorScheme.primary
                              : null,
                          fontSize: 14,
                        ),
                        selectedTitleStyle: TextStyle(
                          color: currentLocation == e.route
                              ? theme.colorScheme.primary
                              : null,
                          fontSize: 14,
                        ),
                        hasSelectedLine: true,
                        isSelected: e.isRoot
                            ? currentLocation == RootRoute.path
                            : currentLocation.contains(e.route),
                        onTap: () => e.onTap?.call(context),
                        title: e.label,
                        icon: e.icon,
                        selectedIcon: e.selectedIcon,
                      );
                    }).toList(),
                  ),
                ),
                Expanded(child: shell),
              ],
            );
          }

          return PopScope(
            canPop: canPop.value,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              final confirm =
                  await ConfirmModal.show(
                    context,
                    title: 'Exit',
                    message: 'Are you sure you want to exit?',
                  ) ??
                  false;
              if (context.mounted && confirm) {
                context.canPop();
              }
            },
            child: Scaffold(
              body: shell,
              bottomNavigationBar: MobileBottomNav(
                index: shell.currentIndex,
                list: items,
                state: routerState,
              ),
            ),
          );
        },
      ),
    );
  }
}
