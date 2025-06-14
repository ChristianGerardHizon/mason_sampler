import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart'
    show $appRoutes;
import 'package:{{packageName.snakeCase()}}/src/core/utils/router_utils.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'main.routes.dart';

part 'router.g.dart';

typedef TypeRouteData = TypedRoute<RouteData>;

final rootKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: RootRoute.path,
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    redirect: (context, state) => RouterUtils.redirect(context, state, ref),
    routes: $appRoutes,
    errorBuilder: RouterUtils.errorBuilder,
  );
}

class RootRoute {
  const RootRoute();

  static String path = '/';

  go(BuildContext context) {
    context.go(path);
  }
}
