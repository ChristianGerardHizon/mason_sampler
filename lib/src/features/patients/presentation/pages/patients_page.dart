// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// system imports
import 'package:mason_sampler/src/features/patients/presentation/widgets/patient_table.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(title: Text('Patients Page')),
      body: PatientTable(),
    );
  }
}
