import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/controllers/scaffold_controller.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/custom_navbar_item.dart';

class MobileBottomNav extends HookConsumerWidget {
  final List<CustomNavigationBarItem> list;
  final GoRouterState state;
  final int index;
  final int maxItems;

  const MobileBottomNav({
    super.key,
    required this.list,
    required this.index,
    required this.state,
    this.maxItems = 3,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    ///
    /// routes to show in the bottom nav
    ///

    final combinedList = [
      ...list.take(maxItems),
      CustomNavigationBarItem(
        route: RootRoute.path,
        icon: Icon(MIcons.dotsHorizontalCircleOutline),
        label: 'More',
        onTap: (context) {
          final scaffold = ref.read(scaffoldControllerProvider).currentState;
          scaffold?.openDrawer();
        },
      ),
    ];

    final finalList = combinedList
        .mapWithIndex((item, index) {
          if (item.isMobile) return item;
          return null;
        })
        .whereType<CustomNavigationBarItem>()
        .toList();

    ///
    ///
    ///
    bool shouldShowBottomNav(String? path) {
      if (path == null) return false;
      return list.any((item) => item.route == path);
    }

    ///
    ///
    ///
    onRouteChanged(int index, List<CustomNavigationBarItem> list) {
      final item = list[index];
      item.onTap?.call(context);
    }

    ///
    ///
    ///
    int bottomNavIndeCalulator(
      List<CustomNavigationBarItem> list,
      String? path,
    ) {
      try {
        final value = combinedList.indexWhere((item) => item.route == path);
        if (value == -1) return combinedList.length - 1;
        return value;
      } catch (e) {
        return combinedList.length - 1;
      }
    }

    ///
    ///
    ///
    if (shouldShowBottomNav(state.fullPath) == false) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0),
        BottomNavigationBar(
          items: finalList,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 0,
          currentIndex: bottomNavIndeCalulator(finalList, state.fullPath),
          selectedFontSize: 13,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
          selectedItemColor: theme.colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => onRouteChanged(index, finalList),
        ),
      ],
    );
  }
}
