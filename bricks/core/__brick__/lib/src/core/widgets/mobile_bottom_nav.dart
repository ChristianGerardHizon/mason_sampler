import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/custom_navbar_item.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';

class MobileBottomNav extends StatelessWidget {
  final List<CustomNavigationBarItem> list;
  final GoRouterState state;
  final int index;

  const MobileBottomNav({
    super.key,
    required this.list,
    required this.index,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ///
    /// routes to show in the bottom nav
    ///
    final routes = <String>[RootRoute.path];

    final combinedList = [
      ...list,
      CustomNavigationBarItem(
        route: RootRoute.path,
        icon: Icon(Icons.more),
        label: 'More',
      ),
    ];

    final finalList = combinedList
        .mapWithIndex((item, index) {
          if (routes.contains(item.route)) return item;
          return null;
        })
        .whereType<CustomNavigationBarItem>()
        .toList();

    ///
    ///
    ///
    bool shouldShowBottomNav(String? path) {
      if (path == null) return false;
      return routes.contains(path);
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
      return list.indexWhere((item) => item.route == path);
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
