import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mason_sampler/src/core/models/custom_navbar_item.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/core/routing/router.dart';

part 'nav_items_controller.g.dart';

@riverpod
class NavItemsController extends _$NavItemsController {
  @override
  FutureOr<List<CustomNavigationBarItem>> build() {
    return [
      CustomNavigationBarItem(
        isRoot: true,
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
