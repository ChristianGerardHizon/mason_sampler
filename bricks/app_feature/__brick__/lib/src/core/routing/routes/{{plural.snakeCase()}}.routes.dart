part of '../main.routes.dart';

class {{plural.pascalCase()}}BranchData extends StatefulShellBranchDataData {
  const {{plural.pascalCase()}}BranchDataData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<{{plural.pascalCase()}}PageRoute>(path: {{plural.pascalCase()}}PageRoute.path),
    TypedGoRoute<{{singular.pascalCase()}}FormPageRoute>(path: {{singular.pascalCase()}}FormPageRoute.path),
    TypedGoRoute<{{singular.pascalCase()}}PageRoute>(path: {{singular.pascalCase()}}PageRoute.path),
  ];
}

@TypedGoRoute<{{plural.pascalCase()}}PageRoute>(path: {{plural.pascalCase()}}PageRoute.path)
class {{plural.pascalCase()}}PageRoute extends GoRouteData {
  const {{plural.pascalCase()}}PageRoute();
  static const path = '/{{plural.lowerCase()}}';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const {{plural.pascalCase()}}Page();
  }
}

@TypedGoRoute<{{singular.pascalCase()}}FormPageRoute>(path: {{singular.pascalCase()}}FormPageRoute.path)
class {{singular.pascalCase()}}FormPageRoute extends GoRouteData {
  const {{singular.pascalCase()}}FormPageRoute({this.id});
  static const path = '/form/{{singular.lowerCase()}}';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}FormPage(id: id);
  }
}

@TypedGoRoute<{{singular.pascalCase()}}PageRoute>(path: {{singular.pascalCase()}}PageRoute.path)
class {{singular.pascalCase()}}PageRoute extends GoRouteData {
  const {{singular.pascalCase()}}PageRoute(this.id);
  static const path = '/{{singular.lowerCase()}}/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}Page(id);
  }
}
