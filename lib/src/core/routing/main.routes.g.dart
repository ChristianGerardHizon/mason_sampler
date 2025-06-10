// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $authLoginPageRoute,
  $authLogoutPageRoute,
  $authDetailsPageRoute,
  $notFoundRoute,
  $rootRouteData,
];

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
          path: '/branches/list',

          factory: $BranchesPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/branches/form',

          factory: $BranchFormPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/branches/id/:id',

          factory: $BranchPageRouteExtension._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/customers/list',

          factory: $CustomersPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/customers/form',

          factory: $CustomerFormPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/customers/id/:id',

          factory: $CustomerPageRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => const RootRouteData();
}

extension $BranchesPageRouteExtension on BranchesPageRoute {
  static BranchesPageRoute _fromState(GoRouterState state) =>
      const BranchesPageRoute();

  String get location => GoRouteData.$location('/branches/list');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BranchFormPageRouteExtension on BranchFormPageRoute {
  static BranchFormPageRoute _fromState(GoRouterState state) =>
      BranchFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/branches/form',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BranchPageRouteExtension on BranchPageRoute {
  static BranchPageRoute _fromState(GoRouterState state) =>
      BranchPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/branches/id/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CustomersPageRouteExtension on CustomersPageRoute {
  static CustomersPageRoute _fromState(GoRouterState state) =>
      const CustomersPageRoute();

  String get location => GoRouteData.$location('/customers/list');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CustomerFormPageRouteExtension on CustomerFormPageRoute {
  static CustomerFormPageRoute _fromState(GoRouterState state) =>
      CustomerFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/customers/form',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CustomerPageRouteExtension on CustomerPageRoute {
  static CustomerPageRoute _fromState(GoRouterState state) =>
      CustomerPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/customers/id/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
