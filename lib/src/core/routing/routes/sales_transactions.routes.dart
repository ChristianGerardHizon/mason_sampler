part of '../main.routes.dart';

class SalesTransactionsBranchData extends StatefulShellBranchData {
  const SalesTransactionsBranchData();

  static const shellBranch = TypedStatefulShellBranch<SalesTransactionsBranchData>(
    routes: <TypeRouteData>[
      TypedGoRoute<SalesTransactionsPageRoute>(path: SalesTransactionsPageRoute.path),
      TypedGoRoute<SalesTransactionFormPageRoute>(path: SalesTransactionFormPageRoute.path),
      TypedGoRoute<SalesTransactionPageRoute>(path: SalesTransactionPageRoute.path),
    ],
  );

}


///
/// List
///

class SalesTransactionsPageRoute extends GoRouteData {
  const SalesTransactionsPageRoute();
  static const path = '/salesTransactions/list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SalesTransactionsPage();
  }
}

///
/// Form
///

class SalesTransactionFormPageRoute extends GoRouteData {
  const SalesTransactionFormPageRoute({this.id});
  static const path = '/salesTransactions/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SalesTransactionFormPage(id: id);
  }
}

///
/// Details
/// 

class SalesTransactionPageRoute extends GoRouteData {
  const SalesTransactionPageRoute(this.id);
  static const path = '/salesTransactions/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SalesTransactionPage(id);
  }
}
