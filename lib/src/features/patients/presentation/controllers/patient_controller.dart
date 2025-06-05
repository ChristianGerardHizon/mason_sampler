import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/features/patients/data/patient_repository.dart';
import 'package:mason_sampler/src/features/patients/domain/patient.dart';

part 'patient_controller.g.dart';

@riverpod
class PatientController extends _$PatientController {
  @override
  Future<Patient> build(String id) async {
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
