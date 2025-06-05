import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/features/patients/data/patient_repository.dart';
import 'package:mason_sampler/src/features/patients/domain/patient.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  @override
  Future<List<Patient>> build() async {
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
