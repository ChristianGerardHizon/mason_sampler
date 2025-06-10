part of '../main.routes.dart';

class AuthsBranchData extends StatefulShellBranchData {
  const AuthsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<AuthLoginPageRoute>(path: AuthLoginPageRoute.path),
    TypedGoRoute<AuthLogoutPageRoute>(path: AuthLogoutPageRoute.path),
    TypedGoRoute<AuthDetailsPageRoute>(path: AuthDetailsPageRoute.path),
  ];
}

///
/// Login
///
@TypedGoRoute<AuthLoginPageRoute>(path: AuthLoginPageRoute.path)
class AuthLoginPageRoute extends GoRouteData {
  const AuthLoginPageRoute({this.email});
  static const path = '/login';

  final String? email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthLoginPage(email: email);
  }
}

///
/// Logout
///
@TypedGoRoute<AuthLogoutPageRoute>(path: AuthLogoutPageRoute.path)
class AuthLogoutPageRoute extends GoRouteData {
  const AuthLogoutPageRoute();
  static const path = '/logout';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthLogoutPage();
  }
}


///
/// Details
/// 
@TypedGoRoute<AuthDetailsPageRoute>(path: AuthDetailsPageRoute.path)
class AuthDetailsPageRoute extends GoRouteData {
  const AuthDetailsPageRoute();
  static const path = '/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthDetailsPage();
  }
}
