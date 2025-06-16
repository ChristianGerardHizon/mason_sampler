part of '../main.routes.dart';

class {{plural.pascalCase()}}BranchData extends StatefulShellBranchData {
  const {{plural.pascalCase()}}BranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<{{singular.pascalCase()}}LoginPageRoute>(path: {{singular.pascalCase()}}LoginPageRoute.path),
    TypedGoRoute<{{singular.pascalCase()}}LogoutPageRoute>(path: {{singular.pascalCase()}}LogoutPageRoute.path),
    TypedGoRoute<{{singular.pascalCase()}}DetailsPageRoute>(path: {{singular.pascalCase()}}DetailsPageRoute.path),
  ];
}

///
/// Login
///
@TypedGoRoute<{{singular.pascalCase()}}LoginPageRoute>(path: {{singular.pascalCase()}}LoginPageRoute.path)
class {{singular.pascalCase()}}LoginPageRoute extends GoRouteData {
  const {{singular.pascalCase()}}LoginPageRoute({this.email});
  static const path = '/login';

  final String? email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}LoginPage(email: email);
  }
}

///
/// Logout
///
@TypedGoRoute<{{singular.pascalCase()}}LogoutPageRoute>(path: {{singular.pascalCase()}}LogoutPageRoute.path)
class {{singular.pascalCase()}}LogoutPageRoute extends GoRouteData {
  const {{singular.pascalCase()}}LogoutPageRoute();
  static const path = '/logout';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}LogoutPage();
  }
}


///
/// Details
/// 
@TypedGoRoute<{{singular.pascalCase()}}DetailsPageRoute>(path: {{singular.pascalCase()}}DetailsPageRoute.path)
class {{singular.pascalCase()}}DetailsPageRoute extends GoRouteData {
  const {{singular.pascalCase()}}DetailsPageRoute();
  static const path = '/{{singular.camelCase()}}';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}DetailsPage();
  }
}
