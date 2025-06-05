/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// system imports
import 'package:mason_sampler/src/core/controllers/table_controller.dart';
import 'package:mason_sampler/src/core/models/dynamic_table_column.dart';
import 'package:mason_sampler/src/core/routing/router.dart';
import 'package:mason_sampler/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:mason_sampler/src/core/widgets/failure_message.dart';
import 'package:mason_sampler/src/core/widgets/modals/app_snackbar.dart';
import 'package:mason_sampler/src/core/widgets/modals/confirm_modal.dart';
import 'package:mason_sampler/src/core/widgets/refresh_button.dart';
import 'package:mason_sampler/src/features/patients/data/patient_repository.dart';
import 'package:mason_sampler/src/features/patients/domain/patient.dart';
import 'package:mason_sampler/src/features/patients/presentation/controllers/patient_table_controller.dart';
import 'package:mason_sampler/src/features/patients/presentation/widgets/patient_card.dart';

class PatientTable extends HookConsumerWidget {
  const PatientTable({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = 'patient';
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(Patient patient) {
      PatientPageRoute(patient.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Patient> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        notifier.clearSelection();
        ref.invalidate(patientTableControllerProvider);
        AppSnackBar.root(message: 'Successfully Deleted');
      });
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [RefreshButton(onPressed: onRefresh)],
      ),
      body: SliverDynamicTableView<Patient>(
        tableKey: tableKey,
        error: FailureMessage.asyncValue(listState),
        isLoading: listState.isLoading,
        items: listState.valueOrNull ?? [],
        onDelete: onDelete,
        onRowTap: onTap,

        ///
        /// Search Features
        ///
        searchCtrl: searchCtrl,
        onCreate: onCreate,

        ///
        /// Table Data
        ///
        columns: [
          DynamicTableColumn(
            header: 'Id',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(overflow: TextOverflow.ellipsis, data.id),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, patient, selected) {
          return PatientCard(
            patient: patient,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(patient);
            },
            selected: selected,
            onLongPress: () {
              notifier.toggleRow(index);
            },
          );
        },
      ),
    );
  }
}
