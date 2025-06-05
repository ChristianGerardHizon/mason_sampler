// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $patientsPageRoute,
  $patientFormPageRoute,
  $patientPageRoute,
  $customersPageRoute,
  $customerFormPageRoute,
  $customerPageRoute,
  $branchesPageRoute,
  $branchFormPageRoute,
  $branchPageRoute,
  $notFoundRoute,
];

RouteBase get $patientsPageRoute => GoRouteData.$route(
  path: '/patients',

  factory: $PatientsPageRouteExtension._fromState,
);

extension $PatientsPageRouteExtension on PatientsPageRoute {
  static PatientsPageRoute _fromState(GoRouterState state) =>
      const PatientsPageRoute();

  String get location => GoRouteData.$location('/patients');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientFormPageRoute => GoRouteData.$route(
  path: '/form/patient',

  factory: $PatientFormPageRouteExtension._fromState,
);

extension $PatientFormPageRouteExtension on PatientFormPageRoute {
  static PatientFormPageRoute _fromState(GoRouterState state) =>
      PatientFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/form/patient',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientPageRoute => GoRouteData.$route(
  path: '/patient/:id',

  factory: $PatientPageRouteExtension._fromState,
);

extension $PatientPageRouteExtension on PatientPageRoute {
  static PatientPageRoute _fromState(GoRouterState state) =>
      PatientPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/patient/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customersPageRoute => GoRouteData.$route(
  path: '/customers',

  factory: $CustomersPageRouteExtension._fromState,
);

extension $CustomersPageRouteExtension on CustomersPageRoute {
  static CustomersPageRoute _fromState(GoRouterState state) =>
      const CustomersPageRoute();

  String get location => GoRouteData.$location('/customers');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customerFormPageRoute => GoRouteData.$route(
  path: '/form/customer',

  factory: $CustomerFormPageRouteExtension._fromState,
);

extension $CustomerFormPageRouteExtension on CustomerFormPageRoute {
  static CustomerFormPageRoute _fromState(GoRouterState state) =>
      CustomerFormPageRoute(id: state.uri.queryParameters['id']);

  String get location => GoRouteData.$location(
    '/form/customer',
    queryParams: {if (id != null) 'id': id},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customerPageRoute => GoRouteData.$route(
  path: '/customer/:id',

  factory: $CustomerPageRouteExtension._fromState,
);

extension $CustomerPageRouteExtension on CustomerPageRoute {
  static CustomerPageRoute _fromState(GoRouterState state) =>
      CustomerPageRoute(state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/customer/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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
