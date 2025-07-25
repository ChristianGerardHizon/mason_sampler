part of '../main.routes.dart';

@TypedGoRoute<NotFoundRoute>(path: NotFoundRoute.path)
class NotFoundRoute extends GoRouteData with _$NotFoundRoute {
  const NotFoundRoute();
  static const path = '/not-found';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox();
  }
}

@TypedStatefulShellRoute<RootRouteData>(branches: RootRouteData.branches)
class RootRouteData extends StatefulShellRouteData {
  const RootRouteData();

  static const String $restorationScopeId = 'restorationScopeId';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootKey;

  @override
  Widget builder(context, state, navigationShell) =>
      AppRoot(shell: navigationShell, routerState: state);

  static const branches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
    // add shell branches here
  ];
}
