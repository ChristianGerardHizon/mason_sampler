part of '../main.routes.dart';

class {{plural.pascalCase()}}BranchData extends StatefulShellBranchData {
  const {{plural.pascalCase()}}BranchData();

  static const shellBranch = TypedStatefulShellBranch<{{plural.pascalCase()}}BranchData>(
    routes: <TypeRouteData>[

      /// Add Branch Routes Here
    ],
  );

}

///
/// Details
/// 
/*
{{^isShellRoute}}@TypedGoRoute<{{singular.pascalCase()}}PageRoute>(path: {{singular.pascalCase()}}PageRoute.path){{/isShellRoute}}
class {{singular.pascalCase()}}PageRoute extends GoRouteData {
  const {{singular.pascalCase()}}PageRoute(this.id);
  static const path = '/{{plural.lowerCase()}}/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{singular.pascalCase()}}Page(id);
  }
}
*/