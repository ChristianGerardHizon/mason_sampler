part of '../main.routes.dart';

class {{plural.pascalCase()}}BranchData extends StatefulShellBranchData {
  const {{plural.pascalCase()}}BranchData();

  static const shellBranch = TypedStatefulShellBranch<{{plural.pascalCase()}}BranchData>(
    routes: <TypeRouteData>[
      TypedGoRoute<{{plural.pascalCase()}}PageRoute>(path: {{plural.pascalCase()}}PageRoute.path),
      TypedGoRoute<{{singular.pascalCase()}}FormPageRoute>(path: {{singular.pascalCase()}}FormPageRoute.path),
      TypedGoRoute<{{singular.pascalCase()}}PageRoute>(path: {{singular.pascalCase()}}PageRoute.path),
    ],
  );

}


///
/// List
///
{{^isShellRoute}}@TypedGoRoute<{{plural.pascalCase()}}PageRoute>(path: {{plural.pascalCase()}}PageRoute.path){{/isShellRoute}}
class {{plural.pascalCase()}}PageRoute extends GoRouteData {
  const {{plural.pascalCase()}}PageRoute();
  static const path = '/{{plural.camelCase()}}/list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const {{plural.pascalCase()}}Page();
  }
}

///
/// Form
///
{{^isShellRoute}}@TypedGoRoute<{{singular.pascalCase()}}FormPageRoute>(path: {{singular.pascalCase()}}FormPageRoute.path){{/isShellRoute}}
class {{singular.pascalCase()}}FormPageRoute extends GoRouteData {
  const {{singular.pascalCase()}}FormPageRoute({this.id});
  static const path = '/{{plural.camelCase()}}/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}FormPage(id: id);
  }
}

///
/// Details
/// 
{{^isShellRoute}}@TypedGoRoute<{{singular.pascalCase()}}PageRoute>(path: {{singular.pascalCase()}}PageRoute.path){{/isShellRoute}}
class {{singular.pascalCase()}}PageRoute extends GoRouteData {
  const {{singular.pascalCase()}}PageRoute(this.id);
  static const path = '/{{plural.camelCase()}}/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}Page(id);
  }
}
