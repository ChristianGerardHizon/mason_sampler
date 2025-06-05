part of '../main.routes.dart';

class PatientsBranchData extends StatefulShellBranchData {
  const PatientsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path),
    TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path),
    TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),
  ];
}


///
/// List
///
@TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path)
class PatientsPageRoute extends GoRouteData {
  const PatientsPageRoute();
  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientsPage();
  }
}

///
/// Form
///
@TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path)
class PatientFormPageRoute extends GoRouteData {
  const PatientFormPageRoute({this.id});
  static const path = '/form/patient';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientFormPage(id: id);
  }
}

///
/// Details
/// 
@TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path)
class PatientPageRoute extends GoRouteData {
  const PatientPageRoute(this.id);
  static const path = '/patient/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPage(id);
  }
}
