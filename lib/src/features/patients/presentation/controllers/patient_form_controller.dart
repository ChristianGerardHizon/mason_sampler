import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/patients/data/patient_repository.dart';
import 'package:mason_sampler/src/features/patients/domain/patient.dart';

part 'patient_form_controller.g.dart';

class PatientFormState {
  final Patient? patient;

  PatientFormState({required this.patient});
}

@riverpod
class PatientFormController extends _$PatientFormController {
  @override
  Future<PatientFormState> build(String? id) async {
    final patientRepo = ref.read(patientRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientFormState(patient: null);
      }
      final patient = await $(patientRepo.get(id));
      return PatientFormState(patient: patient);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
