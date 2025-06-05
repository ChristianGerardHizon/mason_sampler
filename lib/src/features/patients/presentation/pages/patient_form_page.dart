/// package imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/features/patients/presentation/widgets/patient_form.dart';

class PatientFormPage extends HookConsumerWidget {
  const PatientFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Form Page')),
      body: PatientForm(id: id),
    );
  }
}
