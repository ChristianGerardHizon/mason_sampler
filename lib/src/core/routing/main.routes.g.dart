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
          path: '/salesTransactions/list',

          factory: $SalesTransactionsPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/salesTransactions/form',

          factory: $SalesTransactionFormPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/salesTransactions/id/:id',

          factory: $SalesTransactionPageRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => const RootRouteData();
}

extension $SalesTransactionsPageRouteExtension on SalesTransactionsPageRoute {
  static SalesTransactionsPageRoute _fromState(GoRouterState state) =>
      const SalesTransactionsPageRoute();

  String get location => GoRouteData.$location('/salesTransactions/list');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalesTransactionFormPageRouteExtension
    on SalesTransactionFormPageRoute {
  static SalesTransactionFormPageRoute _fromState(GoRouterState state) =>
      SalesTransactionFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/salesTransactions/form',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalesTransactionPageRouteExtension on SalesTransactionPageRoute {
  static SalesTransactionPageRoute _fromState(GoRouterState state) =>
      SalesTransactionPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/salesTransactions/id/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
