part of '../main.routes.dart';

class CustomersBranchData extends StatefulShellBranchData {
  const CustomersBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<CustomersPageRoute>(path: CustomersPageRoute.path),
    TypedGoRoute<CustomerFormPageRoute>(path: CustomerFormPageRoute.path),
    TypedGoRoute<CustomerPageRoute>(path: CustomerPageRoute.path),
  ];
}


///
/// List
///
@TypedGoRoute<CustomersPageRoute>(path: CustomersPageRoute.path)
class CustomersPageRoute extends GoRouteData {
  const CustomersPageRoute();
  static const path = '/customers';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomersPage();
  }
}

///
/// Form
///
@TypedGoRoute<CustomerFormPageRoute>(path: CustomerFormPageRoute.path)
class CustomerFormPageRoute extends GoRouteData {
  const CustomerFormPageRoute({this.id});
  static const path = '/form/customer';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomerFormPage(id: id);
  }
}

///
/// Details
/// 
@TypedGoRoute<CustomerPageRoute>(path: CustomerPageRoute.path)
class CustomerPageRoute extends GoRouteData {
  const CustomerPageRoute(this.id);
  static const path = '/customer/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomerPage(id);
  }
}
