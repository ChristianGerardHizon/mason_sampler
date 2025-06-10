part of '../main.routes.dart';

class AdminsBranchData extends StatefulShellBranchData {
  const AdminsBranchData();

  static const shellBranch = TypedStatefulShellBranch<AdminsBranchData>(
    routes: <TypeRouteData>[
      TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path),
      TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path),
      TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path),
    ],
  );

}


///
/// List
///

class AdminsPageRoute extends GoRouteData {
  const AdminsPageRoute();
  static const path = '/admins/list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminsPage();
  }
}

///
/// Form
///

class AdminFormPageRoute extends GoRouteData {
  const AdminFormPageRoute({this.id});
  static const path = '/admins/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminFormPage(id: id);
  }
}

///
/// Details
/// 

class AdminPageRoute extends GoRouteData {
  const AdminPageRoute(this.id);
  static const path = '/admins/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminPage(id);
  }
}
