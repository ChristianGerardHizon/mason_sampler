import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/custom_navbar_item.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';

part 'nav_items_controller.g.dart';

@riverpod
class NavItemsController extends _$NavItemsController {
  @override
  FutureOr<List<CustomNavigationBarItem>> build() {
    return [
      CustomNavigationBarItem(
        route: RootRoute.path,
        icon: Icon(MIcons.homeOutline),
        selectedIcon: Icon(MIcons.home),
        label: 'Dashboard',
        onTap: (context) {
          RootRoute().go(context);
        },
      ),

      ///
      /// Add Sections Here
      ///
    ];
  }
}
