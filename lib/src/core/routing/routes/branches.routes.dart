part of '../main.routes.dart';

class BranchesBranchData extends StatefulShellBranchData {
  const BranchesBranchData();

  static const shellBranch = TypedStatefulShellBranch<BranchesBranchData>(
    routes: <TypeRouteData>[
      TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path),
      TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path),
      TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path),
    ],
  );

}


///
/// List
///

class BranchesPageRoute extends GoRouteData {
  const BranchesPageRoute();
  static const path = '/branches/list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BranchesPage();
  }
}

///
/// Form
///

class BranchFormPageRoute extends GoRouteData {
  const BranchFormPageRoute({this.id});
  static const path = '/branches/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchFormPage(id: id);
  }
}

///
/// Details
/// 

class BranchPageRoute extends GoRouteData {
  const BranchPageRoute(this.id);
  static const path = '/branches/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchPage(id);
  }
}
