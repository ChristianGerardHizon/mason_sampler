import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{pakcageName.snakeCase()}}/src/core/routing/router.dart'
    show $appRoutes;
import 'package:{{pakcageName.snakeCase()}}/src/core/utils/router_utils.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'main.routes.dart';

part 'router.g.dart';

typedef TypeRouteData = TypedRoute<RouteData>;

final rootKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    redirect: (context, state) => RouterUtils.redirect(context, state, ref),
    routes: $appRoutes,
    errorBuilder: RouterUtils.errorBuilder,
  );
}
