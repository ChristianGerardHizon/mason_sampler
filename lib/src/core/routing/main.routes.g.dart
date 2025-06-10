// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $branchesPageRoute,
  $branchFormPageRoute,
  $branchPageRoute,
  $authLoginPageRoute,
  $authLogoutPageRoute,
  $authDetailsPageRoute,
  $notFoundRoute,
  $rootRouteData,
];

RouteBase get $branchesPageRoute => GoRouteData.$route(
  path: '/branches',

  factory: $BranchesPageRouteExtension._fromState,
);

extension $BranchesPageRouteExtension on BranchesPageRoute {
  static BranchesPageRoute _fromState(GoRouterState state) =>
      const BranchesPageRoute();

  String get location => GoRouteData.$location('/branches');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $branchFormPageRoute => GoRouteData.$route(
  path: '/form/branch',

  factory: $BranchFormPageRouteExtension._fromState,
);

extension $BranchFormPageRouteExtension on BranchFormPageRoute {
  static BranchFormPageRoute _fromState(GoRouterState state) =>
      BranchFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/form/branch',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $branchPageRoute => GoRouteData.$route(
  path: '/branch/:id',

  factory: $BranchPageRouteExtension._fromState,
);

extension $BranchPageRouteExtension on BranchPageRoute {
  static BranchPageRoute _fromState(GoRouterState state) =>
      BranchPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/branch/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authLoginPageRoute => GoRouteData.$route(
  path: '/login',

  factory: $AuthLoginPageRouteExtension._fromState,
);

extension $AuthLoginPageRouteExtension on AuthLoginPageRoute {
  static AuthLoginPageRoute _fromState(GoRouterState state) =>
      AuthLoginPageRoute(email: state.uri.queryParameters['email']);

  String get location => GoRouteData.$location(
    '/login',
    queryParams: {if (email != null) 'email': email},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authLogoutPageRoute => GoRouteData.$route(
  path: '/logout',

  factory: $AuthLogoutPageRouteExtension._fromState,
);

extension $AuthLogoutPageRouteExtension on AuthLogoutPageRoute {
  static AuthLogoutPageRoute _fromState(GoRouterState state) =>
      const AuthLogoutPageRoute();

  String get location => GoRouteData.$location('/logout');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authDetailsPageRoute => GoRouteData.$route(
  path: '/auth',

  factory: $AuthDetailsPageRouteExtension._fromState,
);

extension $AuthDetailsPageRouteExtension on AuthDetailsPageRoute {
  static AuthDetailsPageRoute _fromState(GoRouterState state) =>
      const AuthDetailsPageRoute();

  String get location => GoRouteData.$location('/auth');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notFoundRoute => GoRouteData.$route(
  path: '/not-found',

  factory: $NotFoundRouteExtension._fromState,
);

extension $NotFoundRouteExtension on NotFoundRoute {
  static NotFoundRoute _fromState(GoRouterState state) => const NotFoundRoute();

  String get location => GoRouteData.$location('/not-found');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rootRouteData => StatefulShellRouteData.$route(
  parentNavigatorKey: RootRouteData.$parentNavigatorKey,
  restorationScopeId: RootRouteData.$restorationScopeId,
  factory: $RootRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/branches',

          factory: $BranchesPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/form/branch',

          factory: $BranchFormPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/branch/:id',

          factory: $BranchPageRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => const RootRouteData();
}
