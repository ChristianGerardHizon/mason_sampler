part of '../main.routes.dart';

class CustomersBranchData extends StatefulShellBranchData {
  const CustomersBranchData();

  static const shellBranch = TypedStatefulShellBranch<CustomersBranchData>(
    routes: <TypeRouteData>[
      TypedGoRoute<CustomersPageRoute>(path: CustomersPageRoute.path),
      TypedGoRoute<CustomerFormPageRoute>(path: CustomerFormPageRoute.path),
      TypedGoRoute<CustomerPageRoute>(path: CustomerPageRoute.path),
    ],
  );

}


///
/// List
///

class CustomersPageRoute extends GoRouteData {
  const CustomersPageRoute();
  static const path = '/customers/list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomersPage();
  }
}

///
/// Form
///

class CustomerFormPageRoute extends GoRouteData {
  const CustomerFormPageRoute({this.id});
  static const path = '/customers/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomerFormPage(id: id);
  }
}

///
/// Details
/// 

class CustomerPageRoute extends GoRouteData {
  const CustomerPageRoute(this.id);
  static const path = '/customers/id/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomerPage(id);
  }
}
